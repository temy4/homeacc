function detectCardType(number) {
    var re = {
        electron: /^(4026|417500|4405|4508|4844|4913|4917)\d+$/,
        maestro: /^(5018|5020|5038|5612|5893|6304|6759|6761|6762|6763|0604|6390)\d+$/,
        dankort: /^(5019)\d+$/,
        unionpay: /^(62|88)\d+$/,
        visa: /^4[0-9]{12}(?:[0-9]{3})?$/,
        mastercard: /^5[1-5][0-9]{14}$/,
        amex: /^3[47][0-9]{13}$/,
        diners: /^3(?:0[0-5]|[68][0-9])[0-9]{11}$/,
        discover: /^6(?:011|5[0-9]{2})[0-9]{12}$/,
        jcb: /^(?:2131|1800|35\d{3})\d{11}$/
    };

    if (re.electron.test(number)) {
        return 'visa_electron';
    } else if (re.maestro.test(number)) {
        return 'maestro';
    } else if (re.dankort.test(number)) {
        return 'dankort';
    } else if (re.unionpay.test(number)) {
        return 'unionpay';
    } else if (re.visa.test(number)) {
        return 'visa';
    } else if (re.mastercard.test(number)) {
        return 'mastercard';
    } else if (re.amex.test(number)) {
        return 'amex';
    } else if (re.diners.test(number)) {
        return 'diners_club';
    } else if (re.discover.test(number)) {
        return 'discover';
    } else if (re.jcb.test(number)) {
        return 'jcb';
    } else {
        return 'unknown';
    }
}

function validateCardNumber(number){    
    test = /^(\d{2,})(\d{1})$/g
    numbers = test.exec(number)
    
    doubled  = "";
    result = 0;

    step = number.length%2;

    for (i = 0; i < number.length; i++){
        if (i % 2 == step){
            doubled = parseInt(number[i]) * 2;
        }
        else{
            dbl_str = doubled.toString()
            for (j = 0; j < dbl_str.length; j++){
                result += parseInt(dbl_str[j]);
            }
            result += parseInt(number[i])
        }
    }
    if ( result % 10 == 0 ){
        return true;
    }
    else{
        return false
    }
}

// function validateCardNumber(number){
//     number = number.toString().replace(/[\s\-]+/gi, '');
    
//     test = /^(\d{2,})(\d{1})$/g
//     numbers = test.exec(number)
    
//     main_part = numbers[1];
//     check_num = numbers[2];
    
//     doubled  = "";
//     result = 0;

//     for (i = 0; i < main_part.length; i++){
//         if (i % 2 == 0){
//             doubled = parseInt(main_part[i]) * 2;
//         }
//         else{
//             dbl_str = doubled.toString();
//             for (j = 0; j < dbl_str.length; j++){
//                 result += parseInt(dbl_str[j]);
//             }
//             result += parseInt(main_part[i]);
//         }
//     }
//     if ( result % 10 == 0 ){
//         return true;
//     }
//     else{
//         return false;
//     }
// }

// function validateCardNumber(number){
//     number = number.toString().replace(/[\s\-]+/gi, '');
    
//     test = /^(\d{2,})(\d{1})$/g
//     numbers = test.exec(number)
    
//     main_part = numbers[1]
//     check_num = parseInt(numbers[2])
//     mp_reverse = main_part.split("").reverse().join("");
    
//     doubled  = 0;
//     result = 0;
// console.log(mp_reverse);
    
//     step = mp_reverse.length % 2

//     for (i = 0; i < mp_reverse.length; i++){
//         if (i % 2 == step){
//             doubled = parseInt(mp_reverse[i]) * 2;
            
//             if (doubled > 9 ){
//                 doubled -= 9;
//             }
            
//             if ( i + 1 == mp_reverse.length){
//                 result += doubled
//                 console.log(result + ': + ' + doubled)
//             }
//         }
//         else{
//             result += parseInt(mp_reverse[i]) + doubled
//             console.log(result + ': ' + doubled + ' + ' + mp_reverse[i])
//         }
//     }
//     if ( result - 10 * Math.floor(result / 10) - parseInt(check_num) == 0){
//         return true;
//     }
//     else{
//         return false;
//     }
// }

$(document).on('ready page:load', function(){
    $('#card_card_number').on('keyup paste', function(){
        card_number = $(this).val().toString().replace(/[\s\-]+/gi, '');
        if( card_number.length > 12 ){
            if(validateCardNumber(card_number)){
                type = detectCardType(card_number)
                $('#card_type').attr('src', '/images/cards/' + type + '.png')
                $('#card_cc_type').val(type);
            }
        }
        else{
            $('#card_type').attr('src', '/images/blank.png');
            $('#card_cc_type').val('');
        }
    })
    $.jMaskGlobals = {
       translation: {
           '0': {pattern: /\d/},
           '9': {pattern: /\d/, optional: true},
           '#': {pattern: /\d/, recursive: true},
           'A': {pattern: /[\*0-9]/},
       }
     };
    $('#card_card_number').mask('AAAA AAAA AAAA ####');
})

function formatDate(date) {
  var monthNames = [ 'января', 'февраля', 'марта', 'апреля', 'мая', 'июня', 'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря' ];

  var day = date.getDate();
  var monthIndex = date.getMonth();
  var year = date.getFullYear();

  return day + ' ' + monthNames[monthIndex] + ' ' + year;
}