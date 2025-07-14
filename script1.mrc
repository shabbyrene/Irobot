on *:JOIN:#Bot-Lounge: {
  if ($nick == $me) { /halt }
  set -u6 %n $nick
  msg $chan Zufallsnachrichten 1: $zufallsnachricht 
  msg $chan Zufallsnachrichten 2: $zufallsnachricht2

  set %maxlen 3
  set %nicklen $len(%n)
  if (%nicklen >= %maxlen) { 
    var -s %f3letter $left(%n,%maxlen)

    ;; Write Methode - Hier muss man die Zeilen genaustens definiern.
    /write -l1 E:\Irobot\ $+ %n $+ -info.txt Name= %n
    /write -l2 E:\Irobot\ $+ %n $+ -info.txt Nicklen= %nicklen
    /write -l3 E:\Irobot\ $+ %n $+ -info.txt Erste-drei-buchstaben= %f3letter

    ;; Writeini Methode - Hier wird Bereich Name und vert kann angegeben werden (Man muss keine Zeilen definieren etc)
    /writeini E:\Irobot\Informations.ini Nickname $+ - $+ %n Name %n
    /writeini E:\Irobot\Informations.ini Nickname $+ - $+ %n Nicklen %nicklen
    /writeini E:\Irobot\Informations.ini Nickname $+ - $+ %n Erste-Drei-Buchstaben %f3letter

    /halt
  }
  if (%nicklen < %maxlen) { 
    var -s %firstletter $left(%n,1)
    ;; Write Methode - Hier muss man die Zeilen genaustens definiern.
    /write -l1 E:\Irobot\ $+ %n $+ -info.txt Name= %n
    /write -l2 E:\Irobot\ $+ %n $+ -info.txt Nicklen= %nicklen
    /write -l3 E:\Irobot\ $+ %n $+ -info.txt Erster-buchstabe= %firstletter

    ;; Writeini Methode - Hier wird Bereich Name und vert kann angegeben werden (Man muss keine Zeilen definieren etc)
    /writeini E:\Irobot\Informations.ini Nickname $+ - $+ %n Name %n
    /writeini E:\Irobot\Informations.ini Nickname $+ - $+ %n Nicklen %nicklen
    /writeini E:\Irobot\Informations.ini Nickname $+ - $+ %n Erster-Buchstabe %firstletter

    /halt
  }    

}

on *:text:!info *:#: {
  var -s %infonick $2
  var %maxlen 3

  ;;; Auslesen der Daten mittels $read und SPeichern in einer Variable und dann per msg wiedergeben
  var -s %infoname $read(E:\Irobot\ $+ %infonick $+ -info.txt, s, Name=)
  var -s %infolen $read(E:\Irobot\ $+ %infonick $+ -info.txt, s, Nicklen=)
  if (%infolen > %maxlen) {
    var %infoletters $read(E:\Irobot\ $+ %infonick $+ -info.txt, s, Erste-drei-buchstaben=)
    var %infoletters2 Ersten Drei Buchstaben: %infoletters
  }

  if (%infolen < %maxlen) {
    var %infoletters $read(E:\Irobot\ $+ %infonick $+ -info.txt, s, Erster-buchstabe=)
    var %infoletters2 Erster Buchstabe: %infoletters
  }


  msg $chan Die (read) Ausgaben:
  msg $chan Name: %infoname
  msg $chan Nicklänge %infolen
  msg $chan %infoletters2

  msg $chan Auslesen mittels readini und Wiedergabe

  msg $chan Name: $readini(E:\Irobot\Informations.ini, Nickname $+ - $+ %infonick , Name)
  msg $chan Länge: $readini(E:\Irobot\Informations.ini, Nickname $+ - $+ %infonick , NickLen)  
  if ($readini(E:\Irobot\Informations.ini, Nickname $+ - $+ %infonick, NickLen) > %maxlen) {
    msg $chan Ersten Drei Buchstaben: $readini(E:\Irobot\Informations.ini, Nickname $+ - $+ %infonick, Erste-drei-buchstaben)
  }

  if ($readini(E:\Irobot\Informations.ini, Nickname $+ - $+ %infonick, NickLen) < %maxlen) {
    msg $chan Erster Buchstabe: $readini(E:\Irobot\Informations.ini, Nickname $+ - $+ %infonick, Erster-buchstabe)
  }


}


alias zufallsnachricht {
  return $read(E:\Irobot\nachrichten.txt)
}

alias zufallsnachricht2 {

  var -s %messageid $rand(1,4)

  if (%messageid == 1) { return Du bist ja immernoch wach %n :) | /halt }
  if (%messageid == 2) { return Du kommst ja auch mal vorbei %n | /halt }
  if (%messageid == 3) { return Hast du dich verlaufen? %n ? | /halt }
  if (%messageid == 4) { return Du kannst wieder gehen hier ist keiner %n | /halt } 
}
