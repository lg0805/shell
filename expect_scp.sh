#!/usr/bin/expect -f
# 获取第一个位置参数
set ip [lindex $argv 0]
set user root
set password p@ssw0rd
set timeout 5

spawn scp -r /etc/hosts $user@$ip:/tmp
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
