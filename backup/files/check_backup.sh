#!/usr/bin/bash

#1.定义全局的变量
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin

#2.定义局部变量
Path=/backup
Date=$(date +%F)

#3.查看flag文件,并对该文件进行校验, 然后将校验的结果保存至result_时间
find $Path/*_${Date} -type f -name "flag_$Date"|xargs md5sum -c >$Path/result_${Date}

#4.将校验的结果发送邮件给管理员
mail -s "Rsync Backup $Date" 343264992@qq.com <$Path/result_${Date}

#5.删除超过7天的校验结果文件, 删除超过180天的备份数据文件
find $Path/ -type f -name "result*" -mtime +7|xargs rm -f
find $Path/ -type d -mtime +180|xargs rm -rf