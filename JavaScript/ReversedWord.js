function spinWords(input){
    return input.split(' ').map(word => word.length >= 5 ? word.split('').reverse().join('') : word).join(' ');
}