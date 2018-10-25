Remove-Variable * -ErrorAction SilentlyContinue
#Encryptor#

<#

I recently listened to a podcast that spoke about Ciphers and this got me interested in
making some sort of cipher program in powershell just as a way to practise some scripting
during any quiet periods in work.

#>

#Let's make a numeric cipher first (Probably easier than working with the alphabet)

<#Start of layer 1 of encryption#>
function layer1_algorithm([int]$stack){
    $stack =  ($stack * 2 + 3) % 10
    return $stack
}

function layer2_algorithm([int]$stack){
    [int]$stack = ($stack / 3 + 6) % 10
    return $stack
}

$input = Read-Host 'Please enter a numeric code you would like to encrypt'
$code

$i = 0
for($i -eq 0; $i -lt $input.Length; $i++){

    $temp = $input.ToString().Substring($i, 1)
    [String]$code += layer1_algorithm($temp)
}
Write-Host 'code : ' $code
<#End of layer 1 of encryption#>


<#Start of layer 2 of encryption#>

#I'm going to encorporate some genetic layer1_algorithms ideas in this layer
write-host "`n`nStart of second layer : "$code

#First it will depend on how many characters are in the code
if($code.Length % 2 -eq 0){#Even amount of characters
    
    #This will swap the first half of the digits with the second half

    $i = 0
    for($i -eq 0; $i -lt $code.Length; $i++){
        $array += @($code.Substring($i,1))
    }
    $half = $array.Length / 2

    $i = 0
    for($i -eq 0; $i -lt $half; $i++){
        $temp1 = $array[$i]
        $temp2 = $array[$i + $half]
        $array[$i + $half] = $temp1
        $array[$i] = $temp2

    }

    $code = ''

    $i = 0
    for($i -eq 0; $i -lt $array.Length; $i++){
        [String]$code += $array[$i]
    }

    Write-Host 'Our new code is : ' $code

}else{#Odd amount of characters

    $i = 0
    for($i -eq 0; $i -lt $code.Length; $i++){
        $array += @($code.Substring($i,1))
    }
    $half = $array.Length / 2

    $i = 0
    for($i -eq 0; $i -lt $half; $i++){
        $temp1 = $array[$i]
        $temp2 = $array[$array.Length - (1 + $i)]
        $array[$i] = $temp2
        
    }


    $code = ''
    $i = 0
    for($i -eq 0; $i -lt $array.Length; $i++){
        [String]$code += $array[$i]
    }

    Write-Host 'Our new code is : ' $code
}

<#End of layer 2 of encryption#>

<#Start of Layer 3 of encryption#>
write-host "`n`nStart of third layer : "$code


$input = $code
$code = 0
$i = 0
for($i -eq 0; $i -lt $input.Length; $i++){

    $temp = $input.ToString().Substring($i, 1)
    [String]$code += layer2_algorithm($temp)
}
Write-Host 'Our new code : ' $code