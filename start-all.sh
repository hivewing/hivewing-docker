#! /usr/bin/env ruby
require 'pathname'
require 'timeout'
require 'colorize'

curdir = Pathname.new(File.dirname(__FILE__))
processes = [
  {dir: curdir, cmd: "sudo docker run --name redis-dev -p 3900:6379 redis:latest"},
  {dir: curdir, cmd: "sudo docker run --name redis-test -p 3901:6379 redis:latest"},

  {dir: curdir, cmd: "sudo docker run --name sqs-dev -p 4100:4568 smaj/spurious-sqs"},
  {dir: curdir, cmd: "sudo docker run --name sqs-test -p 4101:4568 smaj/spurious-sqs"},

  {dir: curdir, cmd: "sudo docker run --name pg-dev -p 4300:5432 -e POSTGRES_PASSWORD=hivewing -e POSTGRES_USER=hivewing -d postgres:latest"},
  {dir: curdir, cmd: "sudo docker run --name pg-test -p 4301:5432 -e POSTGRES_PASSWORD=hivewing -e POSTGRES_USER=hivewing -d postgres:latest"},

  {dir: curdir, cmd: "sudo docker run --name s3-dev -p 4200:4569 smaj/spurious-s3"},
  {dir: curdir, cmd: "sudo docker run --name s3-test -p 4201:4569 smaj/spurious-s3"}
]

$pids = []

def cleanup
  $pids.each do |pid|
    begin
      puts "Killing #{pid}".colorize(:red)
      Process.kill("TERM", pid.to_i)
      Timeout::timeout(30) do
        Process.waitpid(pid)
      end
    rescue Timeout::Error, Errno::EPERM
      Process.kill("KILL", pid.to_i)
    end
  end
end

begin
  $pids = processes.map do |command_description|
  logfile = File.open(curdir.join("log",File.basename(command_description[:cmd]).gsub(/[^0-9a-z]/i,'')+".log"),'w')
    puts
    puts ("Starting " + command_description[:cmd]).colorize(:green)
    puts
    spawn(command_description[:cmd], STDOUT => logfile, STDERR => logfile, :chdir => command_description[:dir])
  end
  puts 'type exit to shutdown'
  input = ""
  while input != "exit"
    print ">"
    input = gets.chomp
  end
  cleanup()
rescue Interrupt => e
  cleanup()
end

trap("SIGINT") {
  cleanup()
}
trap("INT"){
  cleanup()
}
