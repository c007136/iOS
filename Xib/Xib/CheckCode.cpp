// 以下是伪代码

// param：当前的JSON参数组转为字符串
// key：暂定为 “1234567890”

// md5加密后，根据key获得校验码
std::string mcc(std::string param, std::string key)
{
    string result;
    string md5Param = md5( param );
    
    int paramLenght = param.length();
    int keyLenght = param.length();
    
    int j = 0;
    for (int i = 0; i < paramLenght; i++) {
        if (j < keyLenght-1) {
            j++;
        } else {
            j = keyLenght/2;
        }
        
        int sum = param[i] + key[j] + i*2 + j*3;
        result += hex2char( sum%16 );  //求余并转为16进制
    }
    
    return result;
}

// key是静态文本，简单转化一下更好
// 客户端需这般处理，服务端不需要
std::string se(std::string src)
{
    string result;
    
    int len = src.length();
    for (int i = 0; i < len; i++) {
        int sum = src[i]*2 + i/2;
        result += hex2char( sum%16 );
    }
    
    return result;
}


int hex2char(int hex)
{
    if( hex < 10 )
        return (48 + hex);
    else
        return (97 + hex - 10);
}