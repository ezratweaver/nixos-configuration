function cd --argument dir
    if [ dir = "" ]
        z $HOME
    else
        z $dir
    end
end