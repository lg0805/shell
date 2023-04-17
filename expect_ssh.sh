#!/usr/bin/expect -f
# expect 实现 SSH 非交互登录

# 定义变量
set timeout 10
set host [lindex $argv 0]
set user [lindex $argv 1]
set password [lindex $argv 2]

# 执行 ssh 登录
spawn ssh $user@$host
expect {
    "yes/no" {
        # 处理是否信任主机的询问
        send "yes\r"
        exp_continue
    }
    "password:" {
        # 输入密码
        send "$password\r"
    }
}
interact


#[root@server1 ~]# ./expect_ssh.sh 192.168.31.162 root p@ssw0rd
#-  set timeout 10  设置超时时间为10秒，如果执行命令超过此时间，expect 将退出； 
# -  set host [lindex $argv 0] 、 set user [lindex $argv 1] 、 set password [lindex $argv 2]  分别获取传递的参数，即主机名、用户名和密码； 
# -  spawn ssh $user@$host  执行 ssh 命令并连接到远程主机； 
# -  expect  开始接收来自远程主机的输出，并等待匹配特定模式的字符串； 
#     -  "yes/no"  匹配是否信任主机的询问，如果是则发送"yes"确认； 
#     -  "password:"  匹配密码提示符，如果是则发送密码； 
# -  interact  交互模式，即使 expect 程序退出，ssh 进程也会继续运行。 
 