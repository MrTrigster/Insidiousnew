"use strict"

import { $, delay, playSound } from './helpers.js'
import { doPuzzle } from './puzzle-handler.js'

// runs on site load and handles entire  flow
async function start(){

    // reset from previous
    $('.try-again').classList.add('hidden')
    $('.spy-icon').src = 'assets/spy-icon.png'

    const dialing = playSound('assets/dialing.mp3', 0.1)

    // mock loading screen
    setInformationText('LOOB ÜHENDUST')
    await delay(0.8)
    setInformationText('ÜRITAB KOODI AUTENTIDA...')
    await delay(1)
    setInformationText('LIGIPÄÄSU KOOD EI TOIMINUD, KÄSITSI SISESTAMINE VAJALIK')
    await delay(1.5)

    // hide text and show squares
    $('#text-container').classList.toggle('hidden')
    $('#number-container').classList.toggle('hidden')


    // activate puzzle 4 times, break on fail
    let submitted
    let answer
    let result = true

    for (let i = 0; i < 4 && result; i++) {
        [submitted, answer] = await doPuzzle()
        result = (submitted?.toLowerCase() == answer)
    }

    // hide squares and show text
    $('.answer-section').classList.add('hidden')
    $('.number-container').classList.add('hidden')
    $('#text-container').classList.remove('hidden')
    
    // display result
    setInformationText((result) ? 'Turvasüsteemi murdmine edukas' : "Süsteem ei võtnud su koodi vastu")
    
    if(!result) {
    	$('.spy-icon').src = 'assets/failed.png'
    	$('#answer-reveal').textContent = answer
        await delay(5)
    }

    fetch('https://hacking/callback', {
        method: 'POST', 
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            success: result
        }) 
      });

    $(".bg").classList.add('hidden');

    $('#submitted-reveal').textContent = (result) ? 'Hea töö, kood oli' : ((submitted == null) ?  "Aeg sai otsa," : `You wrote "${submitted || ' '}", the`)
}


function setInformationText(text){
    
    const capitalized = text.toUpperCase()
    const infoText = `<span class="capital">${capitalized.charAt(0)}</span>${capitalized.substring(1)}`
    
    $("#loading-text").innerHTML = infoText
}


// count visitors
window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
gtag('js', new Date());
gtag('config', 'G-7E64QM2WXT');


window.addEventListener('message', function(event){
    if (event.data.action == "open") {
        start()
        $(".bg").classList.remove('hidden');
    }
})