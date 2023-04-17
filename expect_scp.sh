#!/usr/bin/expect -f

# This script sets variables for IP address, 
# username, password, and timeout used in login. 
# The IP address is set to the first argument in the script's argument list, 
# while the username is set to "root" and the password is set to "p@ssw0rd". 
# The timeout is set to 5 seconds.
set ip [lindex $argv 0]
set user root
set password p@ssw0rd
set timeout 5

spawn scp -r /etc/hosts $user@$ip:/tmp

# 这段代码用于自动化需要进行yes/no响应和密码输入的过程。
# 当它接收到"yes/no"时，它会发送字符串"yes\r"，
# 而当它接收到"password："字符串时，它会发送变量"$password\r"。
# exp_continue命令告诉程序在发送响应后继续查找更多输入。
expect{
    "yes/no" {
        send "yes\r"
        exp_continue
    }
    "password:" {
        send "$password\r"
    }
}
expect eof

