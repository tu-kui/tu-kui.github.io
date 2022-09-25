@echo off

rd /s /q "docs"
echo 已删除之前构建
pause
hugo -D
echo 构建静态页面完毕
pause