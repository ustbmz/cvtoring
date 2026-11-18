#!/bin/zsh
cd "$(dirname "$0")" || exit 1
port=8765
if lsof -ti tcp:$port >/dev/null 2>&1; then
  echo "端口 $port 已被占用，请先关闭占用程序或改用其他端口。"
  read -r "?按回车键退出..."
  exit 1
fi
python3 -m http.server "$port" >/dev/null 2>&1 &
server_pid=$!
sleep 1
open "http://localhost:$port"
echo "转换工具已启动：http://localhost:$port"
echo "关闭此终端窗口即可停止服务。"
wait $server_pid
