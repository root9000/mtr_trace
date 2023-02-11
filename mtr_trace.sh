echo -e "\n该小工具可以为你检查本服务器到中国北京、上海、深圳的[回程网络]类型\n"
read -p "按Enter(回车)开始启动检查..." sdad

iplise=(60.170.202.1 58.242.160.1 120.209.28.1 117.65.108.1 36.32.130.1 112.31.144.1)
iplocal=(安徽电信A 安徽联通A 安徽移动A 安徽电信B 安徽联通B 安徽移动B)
echo "开始安装mtr命令..."
apt update -y && apt install mtr -y
yum clean all && yum makecache && yum install mtr -y
clear
echo -e "\n正在测试,请稍等..."
echo -e "——————————————————————————————\n"
for i in {0..8}; do
	mtr -r --n --tcp ${iplise[i]} > /root/traceroute_testlog
	grep -q "59\.43\." /root/traceroute_testlog
	if [ $? == 0 ];then
		grep -q "202\.97\."  /root/traceroute_testlog
		if [ $? == 0 ];then
		echo -e "目标:${iplocal[i]}[${iplise[i]}]\t回程线路:\033[1;32m电信CN2 GT\033[0m"
		else
		echo -e "目标:${iplocal[i]}[${iplise[i]}]\t回程线路:\033[1;31m电信CN2 GIA\033[0m"
		fi
	else
		grep -q "202\.97\."  /root/traceroute_testlog
		if [ $? == 0 ];then
			grep -q "219\.158\." /root/traceroute_testlog
			if [ $? == 0 ];then
			echo -e "目标:${iplocal[i]}[${iplise[i]}]\t回程线路:\033[1;33m联通169\033[0m"
			else
			echo -e "目标:${iplocal[i]}[${iplise[i]}]\t回程线路:\033[1;34m电信163\033[0m"
			fi
		else
				grep -q "218\.105\."  /root/traceroute_testlog
				if [ $? == 0 ];then
				echo -e "目标:${iplocal[i]}[${iplise[i]}]\t回程线路:\033[1;35m联通9929\033[0m"
				else
					grep -q "219\.158\."  /root/traceroute_testlog
					if [ $? == 0 ];then
						grep -q "219\.158\.113\." /root/traceroute_testlog
						if [ $? == 0 ];then
						echo -e "目标:${iplocal[i]}[${iplise[i]}]\t回程线路:\033[1;33m联通AS4837\033[0m"
						else
						echo -e "目标:${iplocal[i]}[${iplise[i]}]\t回程线路:\033[1;33m联通169\033[0m"
						fi
					else				
						grep -q "223\.120\."  /root/traceroute_testlog
						if [ $? == 0 ];then
						echo -e "目标:${iplocal[i]}[${iplise[i]}]\t回程线路:\033[1;35m移动CMI\033[0m"
						else
							grep -q "221\.183\."  /root/traceroute_testlog
							if [ $? == 0 ];then
							echo -e "目标:${iplocal[i]}[${iplise[i]}]\t回程线路:\033[1;35m移动cmi\033[0m"
							else
							echo -e "目标:${iplocal[i]}[${iplise[i]}]\t回程线路:其他"
						fi
					fi
				fi
			fi
		fi
	fi
echo 
done
rm -f /root/traceroute_testlog
echo -e "\n——————————————————————————————\n本脚本测试结果为TCP回程路由,非ICMP回程路由 仅供参考,以最新IP段为准 谢谢\n"
