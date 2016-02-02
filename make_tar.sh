cd ~
vim_path=.vim
backup_date=`date +%Y%m%d`
echo $backup_date
if [ x$1 != x"full" ]
then
    echo "tar --exclude .git -czvf vimrc-$backup_date-thin.tar.gz $vim_path"
    tar --exclude .git -czvf vimrc-$backup_date-mini.tar.gz $vim_path
else
    echo "tar -czvf vimrc-$backup_date-all.tar.gz $vim_path"
    tar -czvf vimrc-$backup_date-full.tar.gz $vim_path
fi

cd -
echo "Backup Finished "$backup_date

