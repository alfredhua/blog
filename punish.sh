#!/bin/bash

npm run build

tar -cf public.tar public
echo '压缩文件'

scp public.tar root@39.98.143.124:/root
echo '发布文件'

ssh root@39.98.143.124 'rm -rf public/'

echo '删除远程部署目录'

ssh root@39.98.143.124 'tar -xvf public.tar'

echo '发布完成'

rm -rf public*