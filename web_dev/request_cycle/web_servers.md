**What are some of the key design philosophies of the Linux operating system?**

Linux is an operating system originally developed by Linus Torvalds as an attemp to emulate Minix, which in itself was an attempt to emulate Unix. It is a powerful OS with a robust built-in toolbox that's relatively open. An analogy that I like is saying that Linux is like a car built in the 1960's, you gan get under the hood to tweak or fix things yourself. Windows is like a car built in 2016, the engine is basically hermetically sealed, so there's very little you can do yourself. 

*The Linux model of software development discards the entire concept of organized development, source code control systems, structured bug reporting, and statistical quality control. Linux is, and likely always will be, a hacker's operating system. (By hacker, I mean a feverishly dedicated programmer who enjoys exploiting computers and does interesting things with them. This is the original definition of the term, in contrast to the connotation of hacker as a computer wrongdoer, or outlaw.)*

*There is no single organization responsible for developing Linux. Anyone with enough know-how has the opportunity to help develop and debug the kernel, port new software, write documentation, and help new users. For the most part, the Linux community communicates via mailing lists and Usenet newsgroups. Several conventions have sprung up around the development effort.*

Source: http://www.tldp.org/LDP/gs/node3.html

There are nine major tenets to the Linux philosophy.

* Small is Beautiful
* Each Program Does One Thing Well
* Prototype as Soon as Possible
* Choose Portability Over Efficiency
* Store Data in Flat Text Files
* Use Software Leverage
* Use Shell Scripts to Increase Leverage and Portability
* Avoid Captive User Interfaces
* Make Every Program a Filter

Source: https://opensource.com/business/15/2/how-linux-philosophy-affects-you

**In your own words, what is a VPS (virtual private server)? What, according to your research, are the advantages of using a VPS?**

A Virtual Private server is a virtual server that has been created for experimentation or testing purposes and is not intended to be open to the internet at large.

The advantages of using a VPS include:
* A VPS can run a very wide assortment of Operating Systems;
* Because it is virtual, you can feel more comfortable experimenting since, in the worst case scenario (VPS Ruination), you can easily create a new VPS to work with; 
* You can easily create multiple VPS's each with it's own configuration to test how software might behave across a range of systems;
* You can log into and work with a VPS from any computer or any location, allowing multiple people to use one at the same time if needed.


**Optional bonus question: Why is it considered a bad idea to run programs as the root user on a Linux system?**

There are many commands that can delete or otherwise irrevokably damage important files in the Linux system. When you're running as root there are fewer built in precautions keeping you from running those dangerous commands. In addition programs that you run as root have greater privledges to run certain commands or instructions, so if there was some kind of bug or malicious code in a program you're running as root it could do **bad** things to your system.  
