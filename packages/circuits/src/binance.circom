pragma circom 2.1.5;

include "@zk-email/circuits/email-verifier.circom";
include "./circuits/binance_regex.circom";

template BinanceVerifier(maxHeadersLength, maxBodyLength, n, k, ignoreBodyHashCheck){


    signal input emailHeader[maxHeadersLength];
    signal input pubkey[k];
    signal input signature[k];
    signal input emailHeaderLength;

    signal input address;



       signal output pubkeyHash;




     component EV = EmailVerifier(maxHeadersLength, maxBodyLength, n, k, 1);
   EV.emailHeader <== emailHeader;
    EV.pubkey <== pubkey;
    EV.signature <== signature;
    EV.emailHeaderLength <== emailHeaderLength;

    pubkeyHash <== EV.pubkeyHash;



    signal (subject_regex_out, subject_regex_reveal[maxHeadersLength]) <== BinanceRegex(maxHeadersLength)(emailHeader);
    subject_regex_out === 1;


}

    component main { public [ address ] } = BinanceVerifier(1024, 0 ,121, 17, 1);

