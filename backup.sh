cd ..
backup_date=`date +%Y%m%d`
echo $backup_date
tar --exclude .git -czvf simple$backup_date-thin.tar.gz vimrc/
cd vimrc/
echo "Backup Finished "$backup_date

