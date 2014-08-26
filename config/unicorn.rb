APP_ROOT = "/var/apps/update/current"

worker_processes 4
working_directory APP_ROOT

timeout 30

# This is where we specify the socket.
# We will point the upstream Nginx module to this socket later on
listen "#{APP_ROOT}/tmp/sockets/unicorn.sock", :backlog => 64

pid "#{APP_ROOT}/tmp/pids/unicorn-master.pid"

# Set the path of the log files inside the log folder of the testapp
stderr_path "#{APP_ROOT}/log/unicorn.stderr.log"
stdout_path "#{APP_ROOT}/log/unicorn.stdout.log"

