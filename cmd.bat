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
echo ��1�� hexo g
echo ��2�� hexo s
echo ��3�� hexo d
echo ��q�� exit
echo =================================
echo. 
echo ������ִ�е�������������š�
echo. 
set /p lc= ������
if %lc%==1 goto g
if %lc%==2 goto s
if %lc%==3 goto d
if %lc%==q goto e 
pause

:g
start hexo g
goto start

:s
copy E:\workspace\github\sogrey\sogrey.github.io\404.html E:\workspace\github\sogrey\sogrey.github.io\public\404.html
copy E:\workspace\github\sogrey\sogrey.github.io\baidu_verify_hTO3FZGPz7.html E:\workspace\github\sogrey\sogrey.github.io\public\baidu_verify_hTO3FZGPz7.html
copy E:\workspace\github\sogrey\sogrey.github.io\README.md E:\workspace\github\sogrey\sogrey.github.io\public\README.md
copy E:\workspace\github\sogrey\sogrey.github.io\weichat.html E:\workspace\github\sogrey\sogrey.github.io\public\about\weichat.html
copy E:\workspace\github\sogrey\sogrey.github.io\sogrey.html E:\workspace\github\sogrey\sogrey.github.io\public\about\sogrey.html
start hexo s
goto start

:d
copy E:\workspace\github\sogrey\sogrey.github.io\404.html E:\workspace\github\sogrey\sogrey.github.io\public\404.html
copy E:\workspace\github\sogrey\sogrey.github.io\baidu_verify_hTO3FZGPz7.html E:\workspace\github\sogrey\sogrey.github.io\public\baidu_verify_hTO3FZGPz7.html
copy E:\workspace\github\sogrey\sogrey.github.io\README.md E:\workspace\github\sogrey\sogrey.github.io\public\README.md
copy E:\workspace\github\sogrey\sogrey.github.io\weichat.html E:\workspace\github\sogrey\sogrey.github.io\public\about\weichat.html
copy E:\workspace\github\sogrey\sogrey.github.io\sogrey.html E:\workspace\github\sogrey\sogrey.github.io\public\about\sogrey.html
start hexo d
goto start

:e 
exit 