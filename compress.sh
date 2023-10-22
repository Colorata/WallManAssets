for f in *.png
do
	convert $f -resize 400x400^ -gravity center -extent 400x400 compressed/$(basename $f .png).jpg
done
