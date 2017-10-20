resetterCub=cub5
HC11cub=cub7
ssh $resetterCub "printf \"g 2000\\r\" > \/dev\/ttyS0"
#sleep 1
#ssh $HC11cub "printf \"\\r\" > \/dev\/ttyS0"

