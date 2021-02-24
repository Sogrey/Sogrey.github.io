#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

echo -e '\033[32;40m

  ____        U  ___ u    ____      ____     U _____ u   __   __
 / __"| u      \/"_ \/ U /"___|u U |  _"\ u  \| ___"|/   \ \ / /
<\___ \/       | | | | \| |  _ /  \| |_) |/   |  _|"      \ V /
 u___) |   .-,_| |_| |  | |_| |    |  _ <     | |___     U_|"|_u
 |____/>>   \_)-\___/    \____|    |_| \_\    |_____|      |_|
  )(  (__)       \\\\      _)(|_     //   \\\\_   <<   >>  .-,//|(_
 (__) .github.io(__)    (__)__)   (__)  (__) (__) (__)  \_) (__)  
 
'
echo -e "\033[32;40m [1/3] \033[0m commit 2 dev branch"

git init
git add -A
git commit -m 'deploy dev'
git push -f https://github.com/Sogrey/Sogrey.github.io.git dev

echo -e "\033[32;40m [2/3] \033[0m Compile..."
hexo g

cp 404.html public\\404.html
cp baidu_verify_hTO3FZGPz7.html public\\baidu_verify_hTO3FZGPz7.html
cp README-master.md public\\README.md
cp LICENSE public\\LICENSE
cp weichat.html public\\about\\weichat.html
cp sogrey.html public\\about\\sogrey.html
cp mit.html public\\about\\mit.html
cp apache2.0.html public\\about\\apache2.0.html

echo -e "\033[32;40m [3/3] \033[0m Deploy..."
# hexo d

echo -e "\033[32;40m done \033[0m "
