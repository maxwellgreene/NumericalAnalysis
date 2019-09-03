function binaryConvert()
    number = input('Enter the number \n');
    pow=0;
    while 2^pow < number
        pow=pow+1;
    end
    Dig(1:pow)=0;
    for i = flip(1:pow)
        if number >= 2^(i-1)
            Dig(i) = 1;
            number = abs(number-2^(i-1));
        end
    end
    disp(mat2str(flip(Dig)))
end