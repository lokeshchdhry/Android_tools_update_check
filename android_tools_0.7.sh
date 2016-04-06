#!/bin/bash
pltf_tools_path="/Users/lokeshchoudhary/Desktop/android-sdk-macosx/platform-tools"
build_tools_path="/Users/lokeshchoudhary/Desktop/android-sdk-macosx/build-tools/"
sdk_tools_path="/Users/lokeshchoudhary/Desktop/android-sdk-macosx/tools"
platform_path="/Users/lokeshchoudhary/Desktop/android-sdk-macosx/platforms/"
ndk_path="/Users/lokeshchoudhary/Desktop/androidNDK"

installed_pltf_tools(){
  cd $pltf_tools_path
  installed_pltf_tools=$(grep "Pkg.Revision=" source.properties|awk -F "Pkg.Revision=" '{print $2}')
  echo $(date) "---> Installed platform tools: "$installed_pltf_tools
}
check_android_pltf_tools(){
  installed_pltf_tools
  b=$(android list sdk --all|grep 'Android SDK Platform-tools, revision '|grep -v 'rc'|awk -F "revision " '{print $2}')
  if [ "$b" != "$installed_pltf_tools" ]; then
    echo $(date) "---> New Android Platform Tools avaliable: "$b
    echo
    osascript -e 'display notification "New Android Platform Tools Avaliable :'"$b"'" with title "New Android Platform Tools avaliable"'
    # echo "New Android Platform Tools avaliable: "$b |mail -s "New Android Platform Tools Avaliable" lchoudhary@appcelerator.com
  else
    echo $(date) "---> No new Android Platform Tools update"
    echo
    #osascript -e 'display notification "NO New Android Platform Tools Avaliable" with title "NO New Android Platform Tools avaliable"'
  fi
}

check_RC_android_pltf_tools(){
  installed_pltf_tools
  b=$(android list sdk --all|grep 'Android SDK Platform-tools, revision '|grep 'rc'|awk -F "revision " '{print $2}')
  if [ "$b" != "" ]; then
    if [ "$b" != "$installed_pltf_tools" ]; then
      echo $(date) "---> New RC Android Platform Tools avaliable: "$b
      echo
      osascript -e 'display notification "New RC Android Platform Tools Avaliable :'"$b"'" with title "New RC Android Platform Tools avaliable"'
      # echo "New Android Platform Tools avaliable: "$b |mail -s "New Android Platform Tools Avaliable" lchoudhary@appcelerator.com
    else
      echo $(date) "---> No new RC Android Platform Tools update"
      echo
      #osascript -e 'display notification "NO New Android Platform Tools Avaliable" with title "NO New Android Platform Tools avaliable"'
    fi
  else
    echo $(date) "---> No new RC Android Platform Tools update"
    echo
  fi
}



installed_build_tools(){
  installed_build_tools_folder=$(ls $build_tools_path| sort |grep -v 'preview'|tail -1)
  cd $build_tools_path"/"$installed_build_tools_folder
  installed_build_tools=$(grep "Pkg.Revision=" source.properties|awk -F "Pkg.Revision=" '{print $2}')
  echo $(date) "---> Installed android build tools: :"$installed_build_tools
}
check_android_build_tools(){
  installed_build_tools
  a=$(android list sdk --all|grep 'Android SDK Build-tools, revision '|awk -F 'Android SDK Build-tools, revision ' '{print $2}'|grep -v 'rc'|head -1) #awk '{print $1}'|head -1|awk -F " " '{print $1}')#
  if [ "$a" != "$installed_build_tools" ]; then
    echo $(date) "---> New Android Build Tools updates avaliable: "$a
    osascript -e 'display notification "New Android Build Tools avaliable :'"$a"'" with title "New Android Build Tools avaliable"'
    echo
    # echo "New Android Build Tools updates avaliable: "$a |mail -s "New Android Build Tools Avaliable" lchoudhary@appcelerator.com
  else
    echo $(date) "---> No new Android Build tools updates"
    echo
    #osascript -e 'display notification "NO New Android Build Tools Avaliable" with title "NO New Android Build Tools avaliable"'
  fi
}



installed_RC_build_tools(){
  installed_build_tools_folder=$(ls $build_tools_path| sort |grep 'preview'|tail -1)
  cd $build_tools_path"/"$installed_build_tools_folder
  installed_RC_build_tools=$(grep "Pkg.Revision=" source.properties|awk -F "Pkg.Revision=" '{print $2}')
  echo $(date) "---> Installed RC android build tools: :"$installed_RC_build_tools
}
check_RC_android_build_tools(){
  installed_RC_build_tools
  a=$(android list sdk --all|grep 'Android SDK Build-tools, revision '|awk -F 'Android SDK Build-tools, revision ' '{print $2}'|head -1|grep 'rc') #awk '{print $1}'|head -1|awk -F " " '{print $1}')#
  if [ "$a" != "" ]; then
    if [ "$a" != "$installed_RC_build_tools" ]; then
      echo $(date) "---> New RC Android Build Tools updates avaliable: "$a
      osascript -e 'display notification "New RC Android Build Tools avaliable :'"$a"'" with title "New RC Android Build Tools avaliable"'
      echo
      # echo "New Android Build Tools updates avaliable: "$a |mail -s "New Android Build Tools Avaliable" lchoudhary@appcelerator.com
    else
      echo $(date) "---> No new RC Android Build tools updates"
      echo
      #osascript -e 'display notification "NO New Android Build Tools Avaliable" with title "NO New Android Build Tools avaliable"'
    fi
  else
    echo $(date) "---> No new RC Android Build tools updates"
    echo
  fi
}


installed_android_sdk_tools(){
  cd $sdk_tools_path
  installed_sdk_tools=$(grep "Pkg.Revision=" source.properties|awk -F "Pkg.Revision=" '{print $2}')
  echo $(date) "---> Installed Android SDK tools: "$installed_sdk_tools
}
check_android_sdk_tools(){
  installed_android_sdk_tools
  a=$(android list sdk --all|grep 'Android SDK Tools, revision '|awk -F "Android SDK Tools, revision " '{print $2}')
  b=${a:0:6}
  if [ "$b" != "$installed_sdk_tools" ]; then
    echo $(date) "---> New Android SDK Tools avaliable: "$b 
    osascript -e 'display notification "New Android SDK Tools avaliable :'"$b"'" with title "New Android SDK Tools avaliable"'
    echo
    # echo "New Android SDK Tools avaliable: "$b | mail -s "New Android SDK Tools Avaliable" lchoudhary@appcelerator.com
  else
    echo $(date) "---> No new Android SDK Tools update"
    echo
    #osascript -e 'display notification "NO New Android SDK Tools Avaliable" with title "NO New Android SDK Tools avaliable"'
  fi
}


check_rc_sdk_tools(){
  installed_android_sdk_tools

  avaliable_rc_tools=$(android list sdk --all|grep 'Android SDK Tools, revision '|awk -F "Android SDK Tools, revision " '{print $2}'|grep "rc")
  echo $(date) "---> Avaliable RC tools :"$avaliable_rc_tools
  if [ "$avaliable_rc_tools" != "" ]; then
    if [ "$avaliable_rc_tools" != "$installed_sdk_tools" ]; then
      echo $(date) "---> RC SDK tools avaliable if you would like to install :"$avaliable_rc_tools
      echo
      osascript -e 'display notification "New RC SDK Tools Avaliable :'"$avaliable_rc_tools"'" with title "New RC SDK Tools Avaliable"'
    else
      echo $(date) "---> No new RC SDK tools avaliable"
      echo
      #osascript -e 'display notification "NO RC SDK tools avaliable" with title "NO RC SDK tools avaliable"'
    fi
  else
    echo $(date) "---> No new RC SDK tools avaliable"
    echo
  fi
}


highest_installed_platform(){
highest_API=$(ls $platform_path| sort |tail -1|awk -F '-' '{print $2}')
echo $(date) "---> Highest Installed Android API :"$highest_API
}

check_new_platforms(){
  highest_installed_platform
  b=$(android list sdk --all|grep 'SDK Platform Android'|awk -F 'SDK Platform Android' '{print $2}'|awk -F 'API ' '{print $2}')
  new_API=${b:0:2}
  echo $(date) "---> Highest android API avaliable :"$new_API

  if [ "$new_API" != "$highest_API" ]; then
    echo $(date) "---> New Android Platform Avaliable: "$new_API
    echo
    osascript -e 'display notification "New Android Platform avaliable :'"$new_API"'" with title "New Android Platform avaliable"'
    else
    echo $(date) "---> No new Android Platforms"
    echo
    #osascript -e 'display notification "NO New Android Platforms" with title "NO New Android Platforms"'
  fi
}

check_preview_platforms(){
  highest_installed_platform
  new_preview_API=$(android list sdk --all|grep 'SDK Platform Android'|awk -F 'SDK Platform Android' '{print $2}'|grep 'Preview'|awk -F ' ' '{print $1}')
  echo $(date) "---> Android Preview SDK avaliable :"$new_preview_API

  if [ "$new_preview_API" != "$highest_API" ]; then
    echo $(date) "---> New Android Preview SDK Avaliable: "$new_preview_API
    echo
    osascript -e 'display notification "New Android Preview SDK avaliable :'"$new_preview_API"'" with title "New Android Preview SDK avaliable"'
    else
    echo $(date) "---> No New Preview Android Platforms"
    echo
    #osascript -e 'display notification "NO New Android Platforms" with title "NO New Android Platforms"'
  fi
}


installed_NDK(){
  cd $ndk_path
  latest_NDK_installed=$(ls $ndk_path|sort|tail -1|awk -F "android-ndk-" '{print $2}')
  echo $(date) "---> Highest Installed NDK :"$latest_NDK_installed
}

check_avaliable_NDK(){
  installed_NDK
  url="http://developer.android.com/ndk/downloads/index.html#Downloads"
  ava_ndk=$(curl -s $url|grep "android-ndk-r"|awk -F "android-ndk" '{print $2}'|head -1|awk -F '-' '{print $2}')
  echo $(date) "---> Avaliable NDK :"$ava_ndk

  if [ "$latest_NDK_installed" != "$ava_ndk" ]; then
    echo $(date) "---> New NDK Avaliable :"$ava_ndk
    echo
    osascript -e 'display notification "New Android NDK Avaliable :'"$ava_ndk"'" with title "New Android NDK Avaliable"'
  else
    echo $(date) "---> No New Android NDK Avaliable"
    echo
    #osascript -e 'display notification "No New Android NDK Avaliable" with title "No New Android NDK Avaliable"'
  fi
}

while [ true ]
do
  check_new_platforms
  check_preview_platforms
  check_android_pltf_tools
  check_RC_android_pltf_tools
  check_android_build_tools
  check_RC_android_build_tools
  check_android_sdk_tools
  check_rc_sdk_tools
  check_avaliable_NDK

  sleep 1800
done
