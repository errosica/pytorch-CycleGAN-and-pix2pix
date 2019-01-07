AWS = ubuntu@ec2-34-207-56-187.compute-1.amazonaws.com         #your AWS login
Test_Path = "C:\Users\Evan\Google Drive\Development\Programming Languages\Latex\2018 Classes\Data Mining\Final Project\Data\FSTData\Testing_Examples"
Monet_Path = 

cd ~/pytorch-CycleGAN-and-pix2pix

source activate pytorch_p36
bash ./scripts/download_cyclegan_model.sh style_monet
bash ./scripts/download_cyclegan_model.sh style_vangogh
bash ./scripts/download_cyclegan_model.sh style_cezanne
bash ./scripts/download_cyclegan_model.sh style_ukiyoe

arr=("monet" "vangogh" "cezanne" "ukiyoe")
for i in "${arr[@]}"
do
bash ./scripts/download_cyclegan_model.sh "style_$i"
done

#send testing files (i.e. a folder of images to be transformed)
scp -i "VA_AWSKeyPair.pem" "$Test_Path" -r  $AWS.:~/data/FSTData/Testing_Examples


python test.py --dataroot /home/ubuntu/data/FSTData/Testing_Examples --name style_ukiyoe_pretrained --model test --no_dropout --preprocess scale_width --crop_size 2900


#recieve results
scp -i  "VA_AWSKeyPair.pem" -r $AWS.:./results/style_monet_pretrained/test_latest/images C:\Users\Evan\Desktop\results\CycleGAN