@echo off
COLOR 2
title Sogrey.github.io
mode con cols=35 lines=30
:start
echo ~
echo ~
echo HEXO ���뷢������ 
echo %DATE% %TIME%
echo by��Sogrey
echo https://sogrey.github.io/
echo ~
echo ��ѡ��
echo =================================
echo ��0�� ��ʼ��
echo ��1�� hexo g
echo ��2�� hexo s
echo ��3�� hexo d
echo ��q�� exit
echo =================================
echo. 
echo ������ִ�е�������������š�
echo. 
set /p lc= ������
if %lc%==0 goto init
if %lc%==1 goto g
if %lc%==2 goto s
if %lc%==3 goto d
if %lc%==q goto e 
pause

:init
start npm install
goto start

:g
start hexo g
goto start

:s
copy 404.html public\404.html
copy baidu_verify_hTO3FZGPz7.html public\baidu_verify_hTO3FZGPz7.html
copy README-master.md public\README.md
copy weichat.html public\about\weichat.html
copy sogrey.html public\about\sogrey.html
start hexo s
goto start

:d
copy 404.html public\404.html
copy baidu_verify_hTO3FZGPz7.html public\baidu_verify_hTO3FZGPz7.html
copy README-master.md public\README.md
copy weichat.html public\about\weichat.html
copy sogrey.html public\about\sogrey.html
start hexo d
goto start

:e 
exit 