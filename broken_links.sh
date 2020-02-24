#!/bin/bash

link_walk() {
  wget -o book-of-pf.log -r -l 10 --spider https://openbsd-ru.github.io/book-of-pf
  for file in $(grep "^https://openbsd-ru.github.io/book-of-pf*" book-of-pf.log); do
    echo ${file:29}
  done
}

let misspages=0
let links=0

for file in $(link_walk); do
  printf "\n\n====> %s\n" $file
  let misspages=$misspages+1
  for i in $(grep -r ${file##*/} * | grep -v book-of-pf.log | grep -v http | cut -d ":" -f 1); do
    printf "%s\n" $i
    let links=$links+1
  done
done

printf "\n\nPages missing: %s\nBroken links:  %s\n" $misspages $links
