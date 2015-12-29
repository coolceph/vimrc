cd ..
tar_date=`date +%Y%m%d`
echo $tar_date
tar --exclude .git -czvf vimrc_$tar_date.tar.gz vimrc/
mv vimrc_$tar_date.tar.gz vimrc/
cd vimrc/
echo "Make Tar Finished "$tar_date

