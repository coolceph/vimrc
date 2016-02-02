cd ~
backup_date=`date +%Y%m%d`
echo $backup_date
if [ x$1 != x"full" ]
then
    echo "tar --exclude .git -czvf vimrc-$backup_date-thin.tar.gz vimrc"
    tar --exclude .git -czvf vimrc-$backup_date-mini.tar.gz vimrc
else
    echo "tar -czvf vimrc-$backup_date-all.tar.gz vimrc"
    tar -czvf vimrc-$backup_date-full.tar.gz vimrc
fi

cd -
echo "Backup Finished "$backup_date

