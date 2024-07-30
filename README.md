# Project-Thistle

 This repository for the documentation and RTL implementation of the 8-bit breadboard processor I created during my undergraduate degree.

 This project was my first deep-dive into computer architecture, board level electronics and digital design. I started the project in the 1st year of my Bachelor's degree. I was following the intuitions from the book entitled "But How Do It Know?" by J. Clark Scott. Sometime into the 2nd year of my Bachelor's degree, I came across [Ben Eater's 8-bit breadboard processor YouTube series](https://eater.net/8bit/), and I nearly laid an egg. At first, I told myself that I would not cheat by using Ben's designs. However, after sometime becoming frustrated with my inexperience with hands-on board level electronics, I caved. I learned a significant amount from Ben's videos, which allowed me to create my own, similar, but slightly different micro-instruction architecture design. Breadboard layout considerations in addition to intuitions regarding powerline stability brought about huge improvements in my capabilities. I encourage anyone even vaguely interesting in how a computer actually works to give this project a go, it makes you feel awfully clever for a little while.

 It is important to note, it was named Thistle, because it was a constant thorn in my side. Additionally, I could only afford red wire at the time, as I was a broke student. All the ICs, except for the Arduino Nano and the SRAM IC, where "borrowed" from my university electronics department. Massive shout-out to Myles Meehan and Martin Burke for always being so chill about it.

 ![Thistle](\docs\images\Thistle\Thistle.jpg)
 Project Thistle - An 8-bit Breadboard-based Jellybean Logic Processor

## Project Structure

```
├── ""docs"" => Contains documentation for this project.  
│    ├── ""images"" => Pictures of the physical breadboard verison of this processor
│    ├── ""modules"" => Contains ODT documents detailing each module in the processor.
│    ├── ""schematics"" => Functional diagrams/schematics for the processor and its modules. 
│    ├── ""Specification.odt/.odt.docx"" => Document details the specifications for this processor.  
│    ├── ""Notes.odt"" => Minor document contains a couple of notes that I forgot why I wrote, but am too scared to delete. 
├── ""rtl"" => Contains the Verilog source code for the processor
├── ""verify"" => Contains a series of testbenches for each of the modules and the processor.
```

