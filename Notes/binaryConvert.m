function binaryConvert()
    number = input('Enter the number \n');
    base = input('Enter base \n');
    pow=0;
    while base^pow < number
        pow=pow+1;
    end
    Dig(1:pow)=0;
    for i = flip(1:pow)
        if number >= base^(i-1)
            Dig(i) = 1;
            number = abs(number-base^(i-1));
        end
    end
    disp(mat2str(flip(Dig)))
end