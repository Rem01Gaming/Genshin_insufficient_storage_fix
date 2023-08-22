#!/system/bin/sh
#
# GI -9907 Error fixer
# By Rem01Gaming
# Copyright (c) 2023-2024 Rem01 Gaming <Rem01_Gaming@proton.me>
#
#			GNU GENERAL PUBLIC LICENSE
#			 Version 3, 29 June 2007
#
# Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.
#
# the Code starts executing from here
#
# Import $commit_count from old broken cache_versions_xxxxxxxx
file_old=$(ls ~/sdcard/Android/data/com.miHoYo.GenshinImpact/files/cache_versions_* | head -n 1)
commit_count=$(echo "$file_old" | grep -o '[0-9]*')
#
echo "--------------------------"
echo "GI -9907 Error fixer v1.1        "
echo "By Rem01Gaming"
echo "--------------------------"
sleep 1
echo "Device Information :"
echo ""
sleep 1
echo "Model: $(getprop ro.product.odm.model)"
echo "Android Version: $(getprop ro.build.version.release)"
echo "Build Number: $(getprop ro.build.id)"
echo "Manufacturer: $(getprop ro.product.manufacturer)"
echo "Serial: $(getprop ro.serialno)"
echo "CPU Cores: $(grep -c processor /proc/cpuinfo) "
echo "--------------------------"
sleep 1
echo "Genshin Impact Information:"
echo ""
sleep 1
echo "GI UID: $(cat /sdcard/Android/data/com.miHoYo.GenshinImpact/files/Uidinfo.txt)"
echo "GI Version: $(echo $commit_count)_v$(cat /sdcard/Android/data/com.miHoYo.GenshinImpact/files/ScriptVersion)"
echo "--------------------------"
sleep 2
echo "WARNING: Use this script if you are downloading GI resources"
echo "for first time (NO IN UPDATING STATE)"
echo ""
sleep 2
#
# define ${file}
file="/sdcard/cache_versions_$(echo $commit_count)"
#
echo "Generating ${file}..."
sleep 3
# Record all resource files that have been downloaded into 'cache_versions_xxxxxxxx'
ls /sdcard/Android/data/com.miHoYo.GenshinImpact/files/AssetBundles/blocks/00/ | tee "$file"
#
# complete the file directory header by adding 'AssetBundles/blocks/00/' at the start of each line.
sed -i "s/^/AssetBundles\/blocks\/00\//" "$file"
#
# Add missing files. this files is not in the AssetBundles folder.
sed -i "1i ctable.dat" "$file"
sed -i "2i hardware_model_config.json" "$file"
sleep 2
#
echo "Clean up generated file..."
sleep 1
#
# RiProG, 19/07/2023, fix karriage return and last blank line eliminator function.
# Eliminate all file lists with the extension .tmp , these files are files that have not finished downloading.
grep -v "\.tmp$" "$file" | sed -i "/\.tmp$/d" "$file"
#
# Nuke karriage return character in the file name.
sed -i 's/\r//g' "$file"
#
# Eliminate the last blank line in the file
sed -i '/^$/d' "$file" && printf %s "$(cat "$file")" > "$file"
#
# Just a message :)
echo "Done! Paste the file into your GI folder, and enjoy :)"
