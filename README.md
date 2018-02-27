# CollegeDataHTTPServer
It's a HTTP server to process plain text requests with some brazilian college data information. It was written as a taks for the distributed computing class on Universidade Federal de Alagoas (UFAL) 


## Usage
-It was tested using Julia 0.5.2
You can download it [here](https://julialang.org/downloads/oldreleases.html)

To run it you only need to open the Julia terminal and type
include(".../src/server.jl")

It will create the server on http://localhost:8000/

These resources are created automatically:
UFAL
UFBA
UFSE
UFMG
UFPE
UFRJ
PUCRJ

To get one of these resources you need to 
http://localhost:8000/get/{RESOURCE NAME}/

EX:
http://localhost:8000/get/UFAL/


The POST method syntax is
/post/{new college initials}/{new college name}

EX: 
http://localhost:8000/post/IFAL/Instintuto%20Federal%20de%20Alagoas/

The PUT syntax is
/put/{college initials}/{field 1 ID}/{field 1 new data}/{field 2 ID}/{field 2 new data}

-You dont need to specify all fields.
-Unnexisting fields will be ignored
-Currently there are only 2 fields for each College: Name ("Nome") and Initials ("Sigla")

usage example
http://localhost:8000/put/UFAL/Nome/angry++trebuchet++Shooting++90++kg++projectiles++over++300++meters

http://localhost:8000/put/UFAL/Nome/angry++trebuchet++Shooting++90++kg++projectiles++over++300++meters/Sigla/ATS9KGPO300M

The DELETE syntax is the easiest
/delete/{college initials}

EX:
http://localhost:8000/delete/UFAL/

