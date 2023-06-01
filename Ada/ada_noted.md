
# The Ada Programming Language

Ada is a language used in safety-critial domains. Key proparties are the following:
- Strong typed and has many compiler checks 
- Large system w packages and abstractions
- Built-in concurrency and real time support 
- Exccellent toolf for a wide range of embedded platforms 
  
### The Ravenscar profile 
The full Ada concurrent constructs have been considere non-deterministic and unsuited for high-integrity applications. 
Historically the **_Cyclic-executive_** has been preferred.
The Ravenscar profile defines a restricted sub-set of the constructs that are: 
- Deterministic and analyzable 
- Bounded in memory requirements 
- Sufficient for most real-time applications 

Key restrictions are: 

- Tasks and protected objects declared statically on library level
  - tasks may not terminate
- No task entries
  - Tasks communicate through protected objects & suspension objects
- Atmost one entry per protected object
  - Only Boolean guard 
  - Only quee of length one 
  - No requeue
- No dynamic change of task priority
  - Execption: change caused by celing locking 



### Formal verification w SPARK
Spark is a restricted sub-set of ADA2012. 

- Hevy use of contract aspects from Ada 2012
- Additional pragmas for helping proving tools 
- No acces types or recursion!

With SPARK developers can formally verify: 
- Information flow - no unitialized variables
- Freedom of runtime error 
- Functional correctness
- Security and safety policies 

Spark i used for high integrity systems such as aviation asn security. 


