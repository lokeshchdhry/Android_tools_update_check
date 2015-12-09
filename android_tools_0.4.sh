#!/bin/bash
pltf_tools_path="/Users/lokeshchoudhary/Desktop/android-sdk-macosx/platform-tools"
build_tools_path="/Users/lokeshchoudhary/Desktop/android-sdk-macosx/build-tools/"
sdk_tools_path="/Users/lokeshchoudhary/Desktop/android-sdk-macosx/tools"
platform_path="/Users/lokeshchoudhary/Desktop/android-sdk-macosx/platforms/"

installed_pltf_tools(){
  cd $pltf_tools_path
  installed_pltf_tools=$(grep "Pkg.Revision=" source.properties|awk -F "Pkg.Revision=" '{print $2}')
  echo "Installed platform tools: "$installed_pltf_tools
}
check_android_pltf_tools(){
  installed_pltf_tools
  a=$(android list sdk --all|grep 'Android SDK Platform-tools, revision '|awk -F "Android SDK Platform-tools, revision " '{print $2}')
  b=${a:0:6}
  if [ "$b" != "$installed_pltf_tools" ]; then
    echo "New Android Platform Tools avaliable: "$b
    osascript -e 'display notification "New Android Platform Tools Avaliable:'$b'" with title "New Android Platform Tools avaliable"'
    # echo "New Android Platform Tools avaliable: "$b |mail -s "New Android Platform Tools Avaliable" lchoudhary@appcelerator.com
  else
    echo "No new Android Platform Tools update"
    osascript -e 'display notification "NO New Android Platform Tools Avaliable" with title "NO New Android Platform Tools avaliable"'
  fi
}


installed_build_tools(){
  installed_build_tools=$(ls $build_tools_path| sort |tail -1)
  echo "Installed android build tools: :"$installed_build_tools
}
check_android_build_tools(){
  installed_build_tools
  a=$(android list sdk --all|grep 'Android SDK Build-tools, revision '|awk -F 'Android SDK Build-tools, revision ' '{print $2}'|awk '{print $1}'|head -1|awk -F " " '{print $1}')
  if [ "$a" != "$installed_build_tools" ]; then
    echo "New Android Build Tools updates avaliable: "$a
    osascript -e 'display notification "New Android Build Tools avaliable:'$a'" with title "New Android Build Tools avaliable"'
    # echo "New Android Build Tools updates avaliable: "$a |mail -s "New Android Build Tools Avaliable" lchoudhary@appcelerator.com
  else
    echo "No new Android Build tools updates"
    osascript -e 'display notification "NO New Android Build Tools Avaliable" with title "NO New Android Build Tools avaliable"'
  fi
}


installed_android_sdk_tools(){
  cd $sdk_tools_path
  installed_sdk_tools=$(grep "Pkg.Revision=" source.properties|awk -F "Pkg.Revision=" '{print $2}')
  echo "Installed platform tools: "$installed_sdk_tools
}
check_android_sdk_tools(){
  installed_android_sdk_tools
  a=$(android list sdk --all|grep 'Android SDK Tools, revision '|awk -F "Android SDK Tools, revision " '{print $2}')
  b=${a:0:6}
  if [ "$b" != "$installed_sdk_tools" ]; then
    echo "New Android SDK Tools avaliable: "$b 
    osascript -e 'display notification "New Android SDK Tools avaliable:'$b'" with title "New Android SDK Tools avaliable"'
    # echo "New Android SDK Tools avaliable: "$b | mail -s "New Android SDK Tools Avaliable" lchoudhary@appcelerator.com
  else
    echo "No new Android SDK Tools update"
    osascript -e 'display notification "NO New Android SDK Tools Avaliable" with title "NO New Android SDK Tools avaliable"'
  fi
}

highest_installed_platform(){
a=$(ls $platform_path| sort |tail -1)
highest_API=${a:8:10}
echo "Highest Installed Android API :"$highest_API
}

check_new_platforms(){
  highest_installed_platform
  b=$(android list sdk --all|grep 'SDK Platform Android'|awk -F 'SDK Platform Android' '{print $2}'|awk -F 'API ' '{print $2}')
  new_API=${b:0:2}
  echo "New android API avaliable :"$new_API

  if [ "$new_API" != "$highest_API" ]; then
    echo "New Android Platform Avaliable: "$new_API
    osascript -e 'display notification "New Android Platform avaliable:'$new_API'" with title "New Android Platform avaliable"'
    else
    echo "No new Android Platforms"
    osascript -e 'display notification "NO New Android Platforms" with title "NO New Android Platforms"'
  fi
}

while [ true ]
do
  check_new_platforms
  check_android_pltf_tools
  check_android_build_tools
  check_android_sdk_tools
  sleep 7200
done
