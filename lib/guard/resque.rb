require 'guard'
require 'guard/guard'
require 'timeout'

module Guard
  class Resque < Guard

    DEFAULT_TERM_CHILD = 1
    DEFAULT_SIGNAL = :SIGTERM
    DEFAULT_QUEUE = '*'.freeze
    DEFAULT_COUNT = 1
    DEFAULT_TASK_SINGLE = 'resque:work'.freeze
    DEFAULT_TASK_MULTIPLE = 'resque:workers'.freeze

    # Allowable options are:
    #  - :environment  e.g. 'test'
    #  - :task .e.g 'resque:work'
    #  - :queue e.g. '*'
    #  - :count e.g. 3
    #  - :interval e.g. 5
    #  - :verbose e.g. true
    #  - :vverbose e.g. true
    #  - :trace e.g. true
    #  - :stop_signal e.g. :QUIT or :SIGQUIT
    #  - :stop_timeout in seconds. Defaults to 5 seconds (one more than resque)
    def initialize watchers = [], options = {}
      @options = options
      @pid = nil
      @stop_signal = options[:stop_signal] || DEFAULT_SIGNAL
      @stop_timeout = options[:stop_timeout] || 5

      @options[:term_child] ||= DEFAULT_TERM_CHILD
      @options[:queue] ||= DEFAULT_QUEUE
      @options[:count] ||= DEFAULT_COUNT
      @options[:task] ||= (@options[:count].to_i == 1) ? DEFAULT_TASK_SINGLE : DEFAULT_TASK_MULTIPLE
      super
    end

    def start
      stop
      UI.info 'Resque: Starting...'
      UI.info 'Resque: ' + [ cmd, env.map{|v| v.join('=')} ].join(' ')

      # launch Resque worker
      @pid = spawn(env, cmd)
    end

    def stop
      if @pid
        UI.info 'Resque: Stopping...'
        ::Process.kill @stop_signal, @pid
        begin
          Timeout.timeout(@stop_timeout) do
            ::Process.wait @pid
          end
        rescue Timeout::Error
          UI.info "Resque: Sending SIGKILL as it has taken longer than #{@stop_timeout} to exit. Customize this with the stop_timeout option."
          ::Process.kill :KILL, @pid
          ::Process.wait @pid
        end
        UI.info 'Resque: Stopped'
      end
    rescue Errno::ESRCH
      UI.info 'Resque: lost the worker subprocess!'
    ensure
      @pid = nil
    end

    # Called on Ctrl-Z signal
    def reload
      UI.info 'Resque: Restarting...'
      restart
    end

    # Called on Ctrl-/ signal
    def run_all
      true
    end

    # Called on file(s) modifications
    def run_on_changes paths
      restart
    end

    def restart
      stop
      start
    end

    private

    def cmd
      command = ['bundle exec rake', @options[:task].to_s]

      # trace setting
      command << '--trace' if @options[:trace]

      command.join(' ')
    end

    def env
      var = Hash.new

      var['TERM_CHILD']= @options[:term_child].to_s  if @options[:term_child]
      var['INTERVAL']  = @options[:interval].to_s    if @options[:interval]
      var['QUEUE']     = @options[:queue].to_s       if @options[:queue]
      var['COUNT']     = @options[:count].to_s       if @options[:count]
      var['RAILS_ENV'] = @options[:environment].to_s if @options[:environment]

      var['VERBOSE']  = '1' if @options[:verbose]
      var['VVERBOSE'] = '1' if @options[:vverbose]

      var
    end
  end
end

