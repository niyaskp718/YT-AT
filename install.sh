# Kakathic

Likk="$GITHUB_WORKSPACE"

Taive () { curl -s -L --connect-timeout 20 "$1" -o "$2"; }
Xem () { curl -s -G -L --connect-timeout 20 "$1"; }
Getpro () { grep -m1 "$1=" $Likk/Automatic | cut -d = -f2; }


ListTM="lib
tmp
apk"

for Vak in $ListTM; do
mkdir -p $Vak
done

# Tải tool Revanced
Tv1="$(Xem https://github.com/revanced/revanced-cli/releases | grep '/releases/download' | grep -m1 '.jar' | cut -d \" -f2)"
Taive "https://github.com$Tv1" "$Likk/lib/revanced-cli.jar"
Tv2="$(Xem https://github.com/revanced/revanced-patches/releases | grep '/releases/download' | grep -m1 '.jar' | cut -d \" -f2)"
Taive "https://github.com$Tv2" "$Likk/lib/revanced-patches.jar"
Tv3="$(Xem https://github.com/revanced/revanced-integrations/releases | grep '/releases/download' | grep -m1 '.apk' | cut -d \" -f2)"
Taive "https://github.com$Tv3" "$Likk/lib/revanced-integrations.apk"

# Tải Youtube
Taiyt () {
Upk="https://www.apkmirror.com"
User="User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101 Firefox/102.0"
Getlink () { curl -s -k -L -G -H "$User" "$1" | grep -m1 'forcebaseapk=true' | tr ' ' '\n' | grep -m1 'forcebaseapk=true' | cut -d \" -f2; }
Upk1="$Upk$(Getlink "https://www.apkmirror.com/apk/google-inc/youtube/youtube-$(Getpro Version)-release/youtube-$(Getpro Version)$2-android-apk-download/")"
Upk2="$Upk$(Getlink $Upk1)"
curl -s -k -L -H "$User" $Upk2 -o $Likk/lib/$1
}

Taiyt 'YouTube.apk' '-2'
Taiyt 'YouTube.apks'




if [ "$libchek" == "arm64-v8a" ];then
lib="lib/x86/* lib/x86_64/* lib/armeabi-v7a/*"
ach="arm64"
elif [ "$libchek" == "x86" ];then
lib="lib/x86_64/* lib/arm64-v8a/* lib/armeabi-v7a/*"
ach="x86"
elif [ "$libchek" == "x86_64" ];then
lib="lib/x86/* lib/arm64-v8a/* lib/armeabi-v7a/*"
ach="x64"
else
lib="lib/arm64-v8a/* lib/x86/* lib/x86_64/*"
ach="arm"
fi

zip -q -r -9 "$Likk/apk/YouTube.apk" -d $lib


java -jar $Likk/lib/revanced-cli.jar -m $Likk/lib/revanced-integrations.apk -b $Likk/lib/revanced-patches.jar -a "$Likk/lib/YouTube.apk" -o "$Likk/apk/YouTube.apk" -t $Likk/tmp --cn=kakathic --mount




ls -1 $Likk/lib
ls -1 $Likk/apk