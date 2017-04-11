#!/bin/bash
settings="$1"

if [ ! -f ${0%/*} ]
 then
  cd "${0%/*}"
fi 

rootpath="$(dirs)"

hour="$(date +"%H")"
min="$(date +"%M")"
date="$(date +"%Y""%m""%d")"


intervall=$(grep -Po "(?<=^INTERVALL ).*" $settings)
path=$(grep -Po "(?<=^PATH ).*" $settings)
urlAndSizes=$(grep -Po "(?<=^URLS ).*" $settings)
timeToGenFilm=$(grep -Po "(?<=^TIME ).*" $settings)
filmFromIndex=$(grep -Po "(?<=^FILM ).*" $settings)
duration=$(grep -Po "(?<=^DURATION ).*" $settings)

filmFromIndex=(${filmFromIndex//;/ })


urlAndSizesArr=(${urlAndSizes//;/ })


if [ ! -d $path ]
 then 
  mkdir $path
fi
cd $path

films="films"
if [ ! -d $films ]
 then 
  mkdir $films
fi

montages="montages"
if [ ! -d $montages ]
 then 
  mkdir $montages
fi
cd $montages

if [ ! -d $date ]
 then 
  mkdir $date
fi

cd ..

log="log"
if [ ! -d $log ]
 then 
  mkdir $log
fi
cd $log

if [ ! -d $date ]
 then 
  mkdir $date
fi

cd ..

days="days"
if [ ! -d $days ]
 then 
  mkdir $days
fi
cd $days

if [ ! -d $date ]
 then 
  mkdir $date
fi
cd $date
cd ..
cd .. 

if [ $hour == $timeToGenFilm ] && [ $min == '00' ]
 then
  ffmpeg -f concat -i 'nextfilm.txt' -vsync vfr -pix_fmt yuv420p 'films/'$date'.wmv'
  mv 'nextfilm.txt' 'films/'$date'.txt'
fi

cd ..


urls=()
if [ $(($min % $intervall)) == 0 ]
 then 
{
  a="0"
  for urlAndSize in "${urlAndSizesArr[@]}"
   do
    filename=$hour$min$a
    urlAndSizeArr=(${urlAndSize//>/ })
    url=${urlAndSizeArr[0]}
    size=${urlAndSizeArr[1]}
  
    sizeAndMove=(${size//+/ })
   
    pageresOutput=$(pageres $url 1800x900 --filename=$path'/days/'$date'/'$filename --delay=10)

    if [ ! -f $path'/days/'$date'/'$filename'.png' ]
     then
      convert -size ${sizeAndMove[0]} xc:white $path'/days/'$date'/'$filename'.png'
      echo "Error taking screenshot. Using blank picture instead of "$url
    else
      echo "Taken screenshot of "$url
      convert -crop $size $path'/days/'$date'/'$filename'.png' $path'/days/'$date'/'$filename'.png' 
      echo $url" image cropped to " $size " at " $path'/days/'$date'/'$filename".png"
    fi


   ((a=a+1))
  done

  cd $path
  images=()
  for imageIndex in "${filmFromIndex[@]}" 
   do
    images+=('days/'$date'/'$hour$min$imageIndex'.png')
  done
    

  montage "${images[@]}" -tile 4x1 -geometry +10+10 'montages/'$date'/'$hour$min.'png'
  convert 'montages/'$date'/'$hour$min.'png' -pointsize 100 -background Black -fill White label:$hour':'$min -gravity Center -append 'montages/'$date'/'$hour$min.'png'
  echo 'file '"'"'montages/'$date'/'$hour$min.'png'"'"'' >> 'nextfilm.txt'
  echo 'duration '$duration >> 'nextfilm.txt'
  echo "montage created at " $path"/montages/"$date"/"$hour$min".png"
}>$path'/log/'$date'/'$hour$min'.log'
fi

  

