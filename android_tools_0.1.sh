#!/bin/bash
pltf_tools_path="/Users/lokeshchoudhary/Desktop/android-sdk-macosx/platform-tools"
build_tools_path="/Users/lokeshchoudhary/Desktop/android-sdk-macosx/build-tools/"
sdk_tools_path="/Users/lokeshchoudhary/Desktop/android-sdk-macosx/tools"
platform_path="/Users/lokeshchoudhary/Desktop/android-sdk-macosx/platforms/"

installed_pltf_tools(){
  cd $pltf_tools_path
  installed_sdk_tools=$(grep "Pkg.Revision=" source.properties|awk -F "Pkg.Revision=" '{print $2}')
  echo "Installed platform tools: "$installed_sdk_tools
}
check_android_pltf_tools(){
  installed_pltf_tools
  a=$(android list sdk --all|grep 'Android SDK Platform-tools, revision '|awk -F "Android SDK Platform-tools, revision " '{print $2}')
  b=${a:0:6}
  if [ "$b" != "$installed_sdk_tools" ]; then
    echo "New Android Platform Tools avaliable: "$b
    # echo "New Android Platform Tools avaliable: "$b |mail -s "New Android Platform Tools Avaliable" lchoudhary@appcelerator.com
  else
    echo "No new Android Platform Tools update"
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
    # echo "New Android Build Tools updates avaliable: "$a |mail -s "New Android Build Tools Avaliable" lchoudhary@appcelerator.com
  else
    echo "No new Android Build tools updates"
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
    # echo "New Android SDK Tools avaliable: "$b | mail -s "New Android SDK Tools Avaliable" lchoudhary@appcelerator.com
  else
    echo "No new Android SDK Tools update"
  fi
}

highest_installed_platform(){
highest_installed_platform=$(ls $platform_path| sort |tail -1)
echo ${highest_installed_platform:8:10}
}

check_new_platforms(){
  highest_installed_platform
  a=$(android list sdk --all|grep 'SDK Platform Android'|awk -F 'SDK Platform Android' '{print $2}'|awk -F 'API' '{print $1}')
  echo $a
}

# check_new_platforms
check_android_pltf_tools
check_android_build_tools
check_android_sdk_tools
