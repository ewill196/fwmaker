#!/bin/bash

### variables ####
general_url="data.nag.ru/SNR%20Switches/Firmware/"

S2962_url="SNR-S2962/recommended/"
S2962_dir="/tmp/S2962"

S2965_url="SNR-S2965/recommended/"
S2965_dir="/tmp/S2965"

S2982_url="SNR-S2982G/recommended/"
S2982_dir="/tmp/S2982G"

S2985_url="SNR-S2985G/recommended/"
S2985_dir="/tmp/S2985G"

S2989_url="SNR-S2989G/recommended/"
S2989_dir="/tmp/S2989G"

S2995_url="SNR-S2995G/recommended/"
S2995_dir="/tmp/S2995"

S3850_url="SNR-S3850G/recommended/"
S3850_dir="/tmp/S3850G"

S300G_url="SNR-S300G-24FX/recommended/"
S300G_dir="/tmp/S300G"

S2990X_url="SNR-S2990X-24FQ/recommended/"
S2990X_dir="/tmp/S2990X"

S2990XHA_url="SNR-S2990X-24FQ/recommended/VSF_HA/"
S2990XHA_dir="/tmp/S2990XHA"

S300X_url="SNR-S300X-24FQ/recommended/"
S300X_dir="/tmp/S300X"

S4650X_url="SNR-S4650X-48FQ/recommended/"
S4650X_dir="/tmp/S4650X"

#########################
######  SNR-S2962  ######
#########################

if [[ "$1" == "2962" ]]; then
mkdir $S2962_dir &&

#download the archive
wget -nv -A zip --mirror --no-parent -e robots=off https://$general_url$S2962_url &&

#remove the archive to the special directory and remove old directoty
mv ./data.nag.ru/SNR\ Switches/Firmware/$S2962_url*.zip $S2962_dir/ &&
rm -r ./data.nag.ru/ &&

#extract the archive and delete it
unzip -qq $S2962_dir/*.zip -d $S2962_dir&&
rm -f $S2962_dir/*.zip &&

#get unix-style directory name
S2962_tempdir=$(ls $S2962_dir | grep 2962)

#take a name from new the firmware file
S2962_rawfile=$(ls ./S2962 | grep lic)

#take the first half of firmware directory
first="${S2962_tempdir%(*}"

#take a version from new firware file
left_raw="${S2962_rawfile%)*}"

middle_raw="${left_raw##*(}"

#form a new name for the folder
new_dir="$first($middle_raw)"

#rename the folder
mv $S2962_dir/$S2962_tempdir $S2962_dir/$new_dir &&

#rename the file
old_file=$(ls $S2962_dir/$new_dir | grep img)
mv ./S2962/$S2962_rawfile $S2962_dir/$new_dir/$new_dir.img &&

#remove old IMG file
rm $S2962_dir/$new_dir/$old_file &&

#make new md5sums file

cd $S2962_dir/$new_dir
rm -f MD5SUMS &&
md5sum *.img > MD5SUMS &&
md5sum *.rom >> MD5SUMS &&
cd - > /dev/null

#add new fixes to the changelog file

arr=()
while IFS= read -r line; do
	arr+=("$line")
done <./S2962/new_fixes.txt

for each in "${arr[@]}"
	do
		echo "$each" > /dev/null
	done

for (( idx=${#arr[@]}-1 ; idx>=0 ; idx-- )) ; do
#	echo "${arr[idx]}"
	sed -i "1s/^/${arr[idx]}\n/" $S2962_dir/$new_dir/SNR-S2962_changelog.txt
done


#creating the new firmware archive
cd $S2962_dir
zip -qq -r $new_dir.zip $new_dir &&
cd - > /dev/null

#zip -qq -r $S2962_dir/$new_dir.zip $S2962_dir/$new_dir &&

#final output
WHITE='\033[0;37m'
GREEN='\033[0;32m'

printf "${GREEN}The archive ${WHITE}$new_dir.zip ${GREEN}has been made\n"
fi


#########################
######  SNR-S2965  ######
#########################

if [[ "$1" == "2965" ]]; then
mkdir $S2965_dir &&

#download the archive
wget -nv -A zip --mirror --no-parent -e robots=off https://$general_url$S2965_url &&

#remove the archive to the special directory and remove old directoty
mv ./data.nag.ru/SNR\ Switches/Firmware/$S2965_url*.zip $S2965_dir/ &&
rm -r ./data.nag.ru/ &&

#extract the archive and delete it
unzip -qq $S2965_dir/*.zip -d $S2965_dir&&
rm -f $S2965_dir/*.zip &&

#get unix-style directory name
S2965_tempdir=$(ls $S2965_dir | grep 2965)

#take a name from new the firmware file
S2965_rawfile=$(ls ./S2965 | grep vendor | head -1)
S2965_rawfile3=$(ls ./S2965 | grep lic)

#take the first half of firmware directory
first="${S2965_tempdir%(*}"

#take a version from new firware file
left_raw="${S2965_rawfile%)*}"

middle_raw="${left_raw##*(}"

#form a new name for the folder
new_dir="$first($middle_raw)"

#rename the folder
mv $S2965_dir/$S2965_tempdir $S2965_dir/$new_dir &&

#rename the file
old_file=$(ls $S2965_dir/$new_dir | grep "R1.0,R2.0")
old_file3=$(ls $S2965_dir/$new_dir | grep R3)
mv ./S2965/$S2965_rawfile $S2965_dir/$new_dir/SNR-S2965-48T\(24T_8T\(R1.0\,R2.0\)\)\(RPS_UPS\)_7.0.3.5\($middle_raw\)_nos.img &&
mv ./S2965/$S2965_rawfile3 $S2965_dir/$new_dir/SNR-S2965-8T_R3.0\(RPS_UPS\)_7.0.3.5\($middle_raw\)_nos.img &&

#remove old IMG file
rm $S2965_dir/$new_dir/$old_file &&
rm $S2965_dir/$new_dir/$old_file3 &&

#make new md5sums file

cd $S2965_dir/$new_dir &&

pwd &&

rm -f MD5SUMS &&
md5sum *.img > MD5SUMS &&
md5sum *.rom >> MD5SUMS &&
cd - > /dev/null

#add new fixes to the changelog file

arr=()
while IFS= read -r line; do
	arr+=("$line")
done <./S2965/new_fixes.txt

for each in "${arr[@]}"
	do
		echo "$each" > /dev/null
	done

for (( idx=${#arr[@]}-1 ; idx>=0 ; idx-- )) ; do
	sed -i "1s/^/${arr[idx]}\n/" $S2965_dir/$new_dir/SNR-S2965_changelog.txt
done

#creating the new firmware archive
#zip -qq -r $S2965_dir/$new_dir.zip $S2965_dir/$new_dir &&
cd $S2965_dir
zip -qq -r $new_dir.zip $new_dir &&
cd - > /dev/null

#final output
WHITE='\033[0;37m'
GREEN='\033[0;32m'

printf "${GREEN}The archive ${WHITE}$new_dir.zip ${GREEN}has been made\n"
fi


#########################
######  SNR-S2982  ######
#########################

if [[ "$1" == "2982" ]]; then
mkdir $S2982_dir &&

#download the archive
wget -nv -A zip --mirror --no-parent -e robots=off https://$general_url$S2982_url &&

#remove the archive to the special directory and remove old directoty
mv ./data.nag.ru/SNR\ Switches/Firmware/$S2982_url*.zip $S2982_dir/ &&
rm -r ./data.nag.ru/ &&

#extract the archive and delete it
unzip -qq $S2982_dir/*.zip -d $S2982_dir&&
rm -f $S2982_dir/*.zip &&

#get unix-style directory name
S2982_tempdir=$(ls $S2982_dir | grep 2982)

#take a name from new the firmware file
S2982_rawfile=$(ls ./S2982 | grep lic)

#take the first half of firmware directory
first="${S2982_tempdir%(*}"

#take a version from new firware file
left_raw="${S2982_rawfile%)*}"

middle_raw="${left_raw##*(}"

#form a new name for the folder
new_dir="$first($middle_raw)"

#rename the folder
mv $S2982_dir/$S2982_tempdir $S2982_dir/$new_dir &&

#rename the file
old_file=$(ls $S2982_dir/$new_dir | grep img)
mv ./S2982/$S2982_rawfile $S2982_dir/$new_dir/$new_dir.img &&

#remove old IMG file
rm $S2982_dir/$new_dir/$old_file &&

#make new md5sums file

cd $S2982_dir/$new_dir
rm -f MD5SUMS &&
md5sum *.img > MD5SUMS &&
md5sum *.rom >> MD5SUMS &&
cd - > /dev/null

#add new fixes to the changelog file

arr=()
while IFS= read -r line; do
	arr+=("$line")
done <./S2982/new_fixes.txt

for each in "${arr[@]}"
	do
		echo "$each" > /dev/null
	done

for (( idx=${#arr[@]}-1 ; idx>=0 ; idx-- )) ; do
#	echo "${arr[idx]}"
	sed -i "1s/^/${arr[idx]}\n/" $S2982_dir/$new_dir/SNR-S2982G_changelog.txt
done


#creating the new firmware archive
#zip -qq -r $S2982_dir/$new_dir.zip $S2982_dir/$new_dir &&

cd $S2982_dir
zip -qq -r $new_dir.zip $new_dir &&
cd - > /dev/null

#final output
WHITE='\033[0;37m'
GREEN='\033[0;32m'

printf "${GREEN}The archive ${WHITE}$new_dir.zip ${GREEN}has been made\n"
fi


#########################
######  SNR-S2985  ######
#########################

if [[ "$1" == "2985" ]]; then
mkdir $S2985_dir &&

#download the archive
wget -nv -A zip --mirror --no-parent -e robots=off https://$general_url$S2985_url &&

#remove the archive to the special directory and remove old directoty
mv ./data.nag.ru/SNR\ Switches/Firmware/$S2985_url*.zip $S2985_dir/ &&
rm -r ./data.nag.ru/ &&

#extract the archive and delete it
unzip -qq $S2985_dir/*.zip -d $S2985_dir&&
rm -f $S2985_dir/*.zip &&

#get unix-style directory name
S2985_tempdir=$(ls $S2985_dir | grep 2985)

#take a name from new the firmware file
S2985_rawfile=$(ls ./S2985 | grep vendor)

#take the first half of firmware directory
first="${S2985_tempdir%(*}"

#take a version from new firware file
left_raw="${S2985_rawfile%)*}"

middle_raw="${left_raw##*(}"

#form a new name for the folder
new_dir="$first($middle_raw)"

#rename the folder
mv $S2985_dir/$S2985_tempdir $S2985_dir/$new_dir &&

#rename the file
old_file=$(ls $S2985_dir/$new_dir | grep img)
mv ./S2985/$S2985_rawfile $S2985_dir/$new_dir/$new_dir.img &&

#remove old IMG file
rm $S2985_dir/$new_dir/$old_file &&

#make new md5sums file

cd $S2985_dir/$new_dir
rm -f MD5SUMS &&
md5sum *.img > MD5SUMS &&
md5sum *.rom >> MD5SUMS &&
cd - > /dev/null

#add new fixes to the changelog file

arr=()
while IFS= read -r line; do
	arr+=("$line")
done <./S2985/new_fixes.txt

for each in "${arr[@]}"
	do
		echo "$each" > /dev/null
	done

for (( idx=${#arr[@]}-1 ; idx>=0 ; idx-- )) ; do
#	echo "${arr[idx]}"
	sed -i "1s/^/${arr[idx]}\n/" $S2985_dir/$new_dir/SNR-S2985G_changelog.txt
done


#creating the new firmware archive
cd $S2985_dir
zip -qq -r $new_dir.zip $new_dir &&
cd - > /dev/null

#final output
WHITE='\033[0;37m'
GREEN='\033[0;32m'

printf "${GREEN}The archive ${WHITE}$new_dir.zip ${GREEN}has been made\n"
fi


#########################
######  SNR-S2989  ######
#########################

if [[ "$1" == "2989" ]]; then
mkdir $S2989_dir &&

#download the archive
wget -nv -A zip --mirror --no-parent -e robots=off https://$general_url$S2989_url &&

#remove the archive to the special directory and remove old directoty
mv ./data.nag.ru/SNR\ Switches/Firmware/$S2989_url*.zip $S2989_dir/ &&
rm -r ./data.nag.ru/ &&

#extract the archive and delete it
unzip -qq $S2989_dir/*.zip -d $S2989_dir&&
rm -f $S2989_dir/*.zip &&

#get unix-style directory name
S2989_tempdir=$(ls $S2989_dir | grep 2989)

#take a name from new the firmware file
S2989_rawfile=$(ls ./S2989 | grep vendor)

#take the first half of firmware directory
first="${S2989_tempdir%(*}"

#take a version from new firware file
left_raw="${S2989_rawfile%)*}"

middle_raw="${left_raw##*(}"

#form a new name for the folder
new_dir="$first($middle_raw)"

#rename the folder
mv $S2989_dir/$S2989_tempdir $S2989_dir/$new_dir &&

#rename the file
old_file=$(ls $S2989_dir/$new_dir | grep img)
mv ./S2989/$S2989_rawfile $S2989_dir/$new_dir/$new_dir.img &&

#remove old IMG file
rm $S2989_dir/$new_dir/$old_file &&

#make new md5sums file

cd $S2989_dir/$new_dir
rm -f MD5SUMS &&
md5sum *.img > MD5SUMS &&
#md5sum *.rom >> MD5SUMS &&
cd - > /dev/null

#add new fixes to the changelog file

arr=()
while IFS= read -r line; do
	arr+=("$line")
done <./S2989/new_fixes.txt

for each in "${arr[@]}"
	do
		echo "$each" > /dev/null
	done

for (( idx=${#arr[@]}-1 ; idx>=0 ; idx-- )) ; do
#	echo "${arr[idx]}"
	sed -i "1s/^/${arr[idx]}\n/" $S2989_dir/$new_dir/SNR-S2989G_changelog.txt
done


#creating the new firmware archive
#zip -qq -r $S2989_dir/$new_dir.zip $S2989_dir/$new_dir &&
cd $S2989_dir
zip -qq -r $new_dir.zip $new_dir &&
cd - > /dev/null

#final output
WHITE='\033[0;37m'
GREEN='\033[0;32m'

printf "${GREEN}The archive ${WHITE}$new_dir.zip ${GREEN}has been made\n"
fi

#########################
######  SNR-S2995  ######
#########################

if [[ "$1" == "2995" ]]; then
mkdir $S2995_dir &&

#download the archive
wget -nv -A zip --mirror --no-parent -e robots=off https://$general_url$S2995_url &&

#remove the archive to the special directory and remove old directoty
mv ./data.nag.ru/SNR\ Switches/Firmware/$S2995_url*.zip $S2995_dir/ &&
rm -r ./data.nag.ru/ &&

#extract the archive and delete it
unzip -qq $S2995_dir/*.zip -d $S2995_dir&&
rm -f $S2995_dir/*.zip &&

#get unix-style directory name
S2995_tempdir=$(ls $S2995_dir | grep 2995)

#take a name from new the firmware file
S2995_rawfile=$(ls ./S2995 | grep vendor | head -1)
S2995_rawfile3=$(ls ./S2995 | grep POE)

#take the first half of firmware directory
first="${S2995_tempdir%(*}"

#take a version from new firware file
left_raw="${S2995_rawfile%)*}"

middle_raw="${left_raw##*(}"

#form a new name for the folder
new_dir="$first($middle_raw)"

#rename the folder
mv $S2995_dir/$S2995_tempdir $S2995_dir/$new_dir &&

#rename the file
old_file=$(ls $S2995_dir/$new_dir | grep "24_48" | grep img)
old_file3=$(ls $S2995_dir/$new_dir | grep 48TX | grep img)
mv ./S2995/$S2995_rawfile $S2995_dir/$new_dir/SNR-S2995G-12\(24_48\)FX\(TX\)\(24TX-POE\)_7.5.3.6\($middle_raw\)_nos.img &&
mv ./S2995/$S2995_rawfile3 $S2995_dir/$new_dir/SNR-S2995G-48TX-POE_7.5.3.6\($middle_raw\)_nos.img &&

#remove old IMG file
rm $S2995_dir/$new_dir/$old_file &&
rm $S2995_dir/$new_dir/$old_file3 &&

#make new md5sums file
cd $S2995_dir/$new_dir &&

rm -f MD5SUMS &&
md5sum *.img > MD5SUMS &&
md5sum *.rom >> MD5SUMS &&
cd - > /dev/null

#add new fixes to the changelog file

arr=()
while IFS= read -r line; do
	arr+=("$line")
done <./S2995/new_fixes.txt

for each in "${arr[@]}"
	do
		echo "$each" > /dev/null
	done

for (( idx=${#arr[@]}-1 ; idx>=0 ; idx-- )) ; do
	sed -i "1s/^/${arr[idx]}\n/" $S2995_dir/$new_dir/SNR-S2995G_changelog.txt
done

#creating the new firmware archive
#zip -qq -r $S2995_dir/$new_dir.zip $S2995_dir/$new_dir &&
cd $S2995_dir
zip -qq -r $new_dir.zip $new_dir &&
cd - > /dev/null

#final output
WHITE='\033[0;37m'
GREEN='\033[0;32m'

printf "${GREEN}The archive ${WHITE}$new_dir.zip ${GREEN}has been made\n"
fi


#########################
######  SNR-S3850  ######
#########################

if [[ "$1" == "3850" ]]; then
mkdir $S3850_dir &&

#download the archive
wget -nv -A zip --mirror --no-parent -e robots=off https://$general_url$S3850_url &&

#remove the archive to the special directory and remove old directoty
mv ./data.nag.ru/SNR\ Switches/Firmware/$S3850_url*.zip $S3850_dir/ &&
rm -r ./data.nag.ru/ &&

#extract the archive and delete it
unzip -qq $S3850_dir/*.zip -d $S3850_dir&&
rm -f $S3850_dir/*.zip &&

#get unix-style directory name
S3850_tempdir=$(ls $S3850_dir | grep 3850)

#take a name from new the firmware file
S3850_rawfile=$(ls ./S3850 | grep vendor)

#take the first half of firmware directory
first="${S3850_tempdir%(*}"

#take a version from new firware file
left_raw="${S3850_rawfile%)*}"

middle_raw="${left_raw##*(}"

#form a new name for the folder
new_dir="$first($middle_raw)"

#rename the folder
mv $S3850_dir/$S3850_tempdir $S3850_dir/$new_dir &&

#rename the file
old_file=$(ls $S3850_dir/$new_dir | grep img)
mv ./S3850/$S3850_rawfile $S3850_dir/$new_dir/$new_dir.img &&

#remove old IMG file
rm $S3850_dir/$new_dir/$old_file &&

#make new md5sums file

cd $S3850_dir/$new_dir
rm -f MD5SUMS &&
md5sum *.img > MD5SUMS &&
#md5sum *.rom >> MD5SUMS &&
cd - > /dev/null

#add new fixes to the changelog file

arr=()
while IFS= read -r line; do
	arr+=("$line")
done <./S3850/new_fixes.txt

for each in "${arr[@]}"
	do
		echo "$each" > /dev/null
	done

for (( idx=${#arr[@]}-1 ; idx>=0 ; idx-- )) ; do
#	echo "${arr[idx]}"
	sed -i "1s/^/${arr[idx]}\n/" $S3850_dir/$new_dir/SNR-S3850G_changelog.txt
done


#creating the new firmware archive
#zip -qq -r $S3850_dir/$new_dir.zip $S3850_dir/$new_dir &&
cd $S3850_dir
zip -qq -r $new_dir.zip $new_dir &&
cd - > /dev/null

#final output
WHITE='\033[0;37m'
GREEN='\033[0;32m'

printf "${GREEN}The archive ${WHITE}$new_dir.zip ${GREEN}has been made\n"
fi


#########################
######  SNR-S300G  ######
#########################

if [[ "$1" == "300G" ]]; then
mkdir $S300G_dir &&

#download the archive
wget -nv -A zip --mirror --no-parent -e robots=off https://$general_url$S300G_url &&

#remove the archive to the special directory and remove old directoty
mv ./data.nag.ru/SNR\ Switches/Firmware/$S300G_url*.zip $S300G_dir/ &&
rm -r ./data.nag.ru/ &&

#extract the archive and delete it
unzip -qq $S300G_dir/*.zip -d $S300G_dir&&
rm -f $S300G_dir/*.zip &&

#get unix-style directory name
S300G_tempdir=$(ls $S300G_dir | grep S300G)

#take a name from new the firmware file
S300G_rawfile=$(ls ./S300G | grep vendor)

#take the first half of firmware directory
first="${S300G_tempdir%(*}"

#take a version from new firware file
left_raw="${S300G_rawfile%)*}"

middle_raw="${left_raw##*(}"

#form a new name for the folder
new_dir="$first($middle_raw)"

#rename the folder
mv $S300G_dir/$S300G_tempdir $S300G_dir/$new_dir &&

#rename the file
old_file=$(ls $S300G_dir/$new_dir | grep img)
mv ./S300G/$S300G_rawfile $S300G_dir/$new_dir/$new_dir.img &&

#remove old IMG file
#rm $300G/$new_dir/$S300G_tempdir"_nos.img"
rm $S300G_dir/$new_dir/$old_file &&

#make new md5sums file

cd $S300G_dir/$new_dir
rm -f MD5SUMS &&
md5sum *.img > MD5SUMS &&
md5sum *.rom >> MD5SUMS &&
cd - > /dev/null

#add new fixes to the changelog file

arr=()
while IFS= read -r line; do
	arr+=("$line")
done <./S300G/new_fixes.txt

for each in "${arr[@]}"
	do
		echo "$each" > /dev/null
	done

for (( idx=${#arr[@]}-1 ; idx>=0 ; idx-- )) ; do
#	echo "${arr[idx]}"
	sed -i "1s/^/${arr[idx]}\n/" $S300G_dir/$new_dir/SNR-S300G-24FX_changelog.txt
done


#creating the new firmware archive
#zip -qq -r $S300G_dir/$new_dir.zip $S300G_dir/$new_dir &&
cd $S300G_dir
zip -qq -r $new_dir.zip $new_dir &&
cd - > /dev/null

#final output
WHITE='\033[0;37m'
GREEN='\033[0;32m'

printf "${GREEN}The archive ${WHITE}$new_dir.zip ${GREEN}has been made\n"
fi


#########################
#####  SNR-S2990X  ######
#########################

if [[ "$1" == "2990X" ]]; then
mkdir $S2990X_dir &&

#download the archive
wget -nv -A zip --mirror --no-parent -e robots=off https://$general_url$S2990X_url &&

#remove the archive to the special directory and remove old directoty
mv ./data.nag.ru/SNR\ Switches/Firmware/$S2990X_url*.zip $S2990X_dir/ &&
rm -r ./data.nag.ru/ &&

#extract the archive and delete it
unzip -qq $S2990X_dir/*.zip -d $S2990X_dir&&
rm -f $S2990X_dir/*.zip &&

#get unix-style directory name
S2990X_tempdir=$(ls $S2990X_dir | grep S2990X)

#take a name from new the firmware file
S2990X_rawfile=$(ls ./S2990X | grep vendor)

#take the first half of firmware directory
first="${S2990X_tempdir%(*}"

#take a version from new firware file
left_raw="${S2990X_rawfile%)*}"

middle_raw="${left_raw##*(}"

#form a new name for the folder
new_dir="$first($middle_raw)"

#rename the folder
mv $S2990X_dir/$S2990X_tempdir $S2990X_dir/$new_dir &&

#rename the file
old_file=$(ls $S2990X_dir/$new_dir | grep img)
mv ./S2990X/$S2990X_rawfile $S2990X_dir/$new_dir/$new_dir.img &&

#remove old IMG file
#rm $300G/$new_dir/$S2990X_tempdir"_nos.img"
rm $S2990X_dir/$new_dir/$old_file &&

#make new md5sums file

cd $S2990X_dir/$new_dir
rm -f MD5SUMS &&
md5sum *.img > MD5SUMS &&
md5sum *.rom >> MD5SUMS &&
cd - > /dev/null

#add new fixes to the changelog file

arr=()
while IFS= read -r line; do
	arr+=("$line")
done <./S2990X/new_fixes.txt

for each in "${arr[@]}"
	do
		echo "$each" > /dev/null
	done

for (( idx=${#arr[@]}-1 ; idx>=0 ; idx-- )) ; do
#	echo "${arr[idx]}"
	sed -i "1s/^/${arr[idx]}\n/" $S2990X_dir/$new_dir/SNR-S2990X-24FQ_changelog.txt
done


#creating the new firmware archive
#zip -qq -r $S2990X_dir/$new_dir.zip $S2990X_dir/$new_dir &&
cd $S2990X_dir
zip -qq -r $new_dir.zip $new_dir &&
cd - > /dev/null

#final output
WHITE='\033[0;37m'
GREEN='\033[0;32m'

printf "${GREEN}The archive ${WHITE}$new_dir.zip ${GREEN}has been made\n"
fi

#########################
#####SNR-S2990X-HA ######
#########################

if [[ "$1" == "2990X-HA" ]]; then
mkdir $S2990XHA_dir &&

#download the archive
wget -nv -A zip --mirror --no-parent -e robots=off https://$general_url$S2990XHA_url &&

#remove the archive to the special directory and remove old directoty
mv ./data.nag.ru/SNR\ Switches/Firmware/$S2990XHA_url*.zip $S2990XHA_dir/ &&
rm -r ./data.nag.ru/ &&

#extract the archive and delete it
unzip -qq $S2990XHA_dir/*.zip -d $S2990XHA_dir&&
rm -f $S2990XHA_dir/*.zip &&

#get unix-style directory name
S2990XHA_tempdir=$(ls $S2990XHA_dir | grep S2990X)

#take a name from new the firmware file
S2990XHA_rawfile=$(ls ./S2990XHA | grep vendor)

#take the first half of firmware directory
first="${S2990XHA_tempdir%(*}"

#take a version from new firware file
left_raw="${S2990XHA_rawfile%)*}"

middle_raw="${left_raw##*(}"

#form a new name for the folder
new_dir="$first($middle_raw)"

#rename the folder
mv $S2990XHA_dir/$S2990XHA_tempdir $S2990XHA_dir/$new_dir &&

#rename the file
old_file=$(ls $S2990XHA_dir/$new_dir | grep img)
mv ./S2990XHA/$S2990XHA_rawfile $S2990XHA_dir/$new_dir/$new_dir.img &&

#remove old IMG file
#rm $300G/$new_dir/$S2990X_tempdir"_nos.img"
rm $S2990XHA_dir/$new_dir/$old_file &&

#make new md5sums file

cd $S2990XHA_dir/$new_dir
rm -f MD5SUMS &&
md5sum *.img > MD5SUMS &&
md5sum *.rom >> MD5SUMS &&
cd - > /dev/null

#add new fixes to the changelog file

arr=()
while IFS= read -r line; do
	arr+=("$line")
done <./S2990XHA/new_fixes.txt

for each in "${arr[@]}"
	do
		echo "$each" > /dev/null
	done

for (( idx=${#arr[@]}-1 ; idx>=0 ; idx-- )) ; do
#	echo "${arr[idx]}"
	sed -i "1s/^/${arr[idx]}\n/" "$S2990XHA_dir/$new_dir/SNR-S2990X-24FQ(VSF_HA)_changelog.txt"
done


#creating the new firmware archive
#zip -qq -r $S2990X_dir/$new_dir.zip $S2990X_dir/$new_dir &&
cd $S2990XHA_dir
zip -qq -r $new_dir.zip $new_dir &&
cd - > /dev/null

#final output
WHITE='\033[0;37m'
GREEN='\033[0;32m'

printf "${GREEN}The archive ${WHITE}$new_dir.zip ${GREEN}has been made\n"
fi


#########################
######  SNR-S300X  ######
#########################

if [[ "$1" == "300X" ]]; then
mkdir $S300X_dir &&

#download the archive
wget -nv -A zip --mirror --no-parent -e robots=off https://$general_url$S300X_url &&

#remove the archive to the special directory and remove old directoty
mv ./data.nag.ru/SNR\ Switches/Firmware/$S300X_url*.zip $S300X_dir/ &&
rm -r ./data.nag.ru/ &&

#extract the archive and delete it
unzip -qq $S300X_dir/*.zip -d $S300X_dir&&
rm -f $S300X_dir/*.zip &&

#get unix-style directory name
S300X_tempdir=$(ls $S300X_dir | grep S300X)

#take a name from new the firmware file
S300X_rawfile=$(ls ./S300X | grep vendor)

#take the first half of firmware directory
first="${S300X_tempdir%(*}"

#take a version from new firware file
left_raw="${S300X_rawfile%)*}"

middle_raw="${left_raw##*(}"

#form a new name for the folder
new_dir="$first($middle_raw)"

#rename the folder
mv $S300X_dir/$S300X_tempdir $S300X_dir/$new_dir &&

#rename the file
old_file=$(ls $S300X_dir/$new_dir | grep img)
mv ./S300X/$S300X_rawfile $S300X_dir/$new_dir/$new_dir.img &&

#remove old IMG file
#rm $300G/$new_dir/$S300X_tempdir"_nos.img"
rm $S300X_dir/$new_dir/$old_file &&

#make new md5sums file

cd $S300X_dir/$new_dir
rm -f MD5SUMS &&
md5sum *.img > MD5SUMS &&
md5sum *.rom >> MD5SUMS &&
cd - > /dev/null

#add new fixes to the changelog file

arr=()
while IFS= read -r line; do
	arr+=("$line")
done <./S300X/new_fixes.txt

for each in "${arr[@]}"
	do
		echo "$each" > /dev/null
	done

for (( idx=${#arr[@]}-1 ; idx>=0 ; idx-- )) ; do
#	echo "${arr[idx]}"
	sed -i "1s/^/${arr[idx]}\n/" $S300X_dir/$new_dir/SNR-S300X-24FQ_changelog.txt
done


#creating the new firmware archive
#zip -qq -r $S300X_dir/$new_dir.zip $S300X_dir/$new_dir &&
cd $S300X_dir
zip -qq -r $new_dir.zip $new_dir &&
cd - > /dev/null

#final output
WHITE='\033[0;37m'
GREEN='\033[0;32m'

printf "${GREEN}The archive ${WHITE}$new_dir.zip ${GREEN}has been made\n"
fi


#########################
###### SNR-S4650X  ######
#########################

if [[ "$1" == "4650" ]]; then
mkdir $S4650X_dir &&

#download the archive
wget -nv -A zip --mirror --no-parent -e robots=off https://$general_url$S4650X_url &&

#remove the archive to the special directory and remove old directoty
mv ./data.nag.ru/SNR\ Switches/Firmware/$S4650X_url*.zip $S4650X_dir/ &&
rm -r ./data.nag.ru/ &&

#extract the archive and delete it
unzip -qq $S4650X_dir/*.zip -d $S4650X_dir&&
rm -f $S4650X_dir/*.zip &&

#get unix-style directory name
S4650X_tempdir=$(ls $S4650X_dir | grep S4650X)

#take a name from new the firmware file
S4650X_rawfile=$(ls ./S4650X | grep vendor)

#take the first half of firmware directory
first="${S4650X_tempdir%(*}"

#take a version from new firware file
left_raw="${S4650X_rawfile%)*}"

middle_raw="${left_raw##*(}"

#form a new name for the folder
new_dir="$first($middle_raw)"

#rename the folder
mv $S4650X_dir/$S4650X_tempdir $S4650X_dir/$new_dir &&

#rename the file
old_file=$(ls $S4650X_dir/$new_dir | grep img)
mv ./S4650X/$S4650X_rawfile $S4650X_dir/$new_dir/$new_dir.img &&

#remove old IMG file
#rm $300G/$new_dir/$S4650X_tempdir"_nos.img"
rm $S4650X_dir/$new_dir/$old_file &&

#make new md5sums file

cd $S4650X_dir/$new_dir
rm -f MD5SUMS &&
md5sum *.img > MD5SUMS &&
#md5sum *.rom >> MD5SUMS &&
cd - > /dev/null

#add new fixes to the changelog file

arr=()
while IFS= read -r line; do
	arr+=("$line")
done <./S4650X/new_fixes.txt

for each in "${arr[@]}"
	do
		echo "$each" > /dev/null
	done

for (( idx=${#arr[@]}-1 ; idx>=0 ; idx-- )) ; do
#	echo "${arr[idx]}"
	sed -i "1s/^/${arr[idx]}\n/" $S4650X_dir/$new_dir/SNR-S4650X-48FQ_changelog.txt
done


#creating the new firmware archive
#zip -qq -r $S4650X_dir/$new_dir.zip $S4650X_dir/$new_dir &&
cd $S4650X_dir
zip -qq -r $new_dir.zip $new_dir &&
cd - > /dev/null

#final output
WHITE='\033[0;37m'
GREEN='\033[0;32m'

printf "${GREEN}The archive ${WHITE}$new_dir.zip ${GREEN}has been made\n"
fi




###########################
###        HELP      ######
###########################

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
	printf "\nArgument:    Description\n\n2962    -    SNR-S2962 Series\n2965    -    SNR-S2965 Series\n2982    -    SNR-S2982G Series\n2985    -    SNR-S2985G Series\n2989    -    SNR-S2989G Series\n2995    -    SNR-S2995 Series\n3850    -    SNR-S3850-24FX\n300G    -    SNR-S300G-24FX\n2990X   -    SNR-S2990X-24FQ\n2990X-HA-    SNR-S2990X-24FQ-VSF_HA\n300X    -    SNR-S300X-24FQ\n4650    -    SNR-S4650X-48FQ\n\n"
fi

if [ "$1" == "-v" ] || [ "$1" == "--version" ]; then
	printf "\nFwmaker is a utility for automation making firmware archives for SNR Switches (NAG LLC)\n\nAuthor: Evgeniy Mirkhasanov, Systems Engineer\nVersion: 0.5\n2022\n\n"
fi
