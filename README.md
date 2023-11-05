


# Simple Admin

### Prerequisite

 - Flutter Version: 3.10.0
 - Dart Version: 3.0.0
### Installing
- Minimum requirements  above
- please put/make `constants.dart` file and make variable  
```static  const  String crudCredential =  '((the credential in email))';``` in `lib/core/utils/`

 ### Demo
Firebase app distribution (in email)

### Codebase
- Clean Architecture:
Clean Architecture really makes the app more maintanable by seperating the layers, as we see in the codebase the goals is to make the relationship between layers loose coupled/decoupled. So, for example if we want to change the `datasource` method we can just change the module, as long as the return object is still the same. Because of that, we don't need to modify the entire codebase for the change. Here is the visualization:
	![Clean Coder Blog](https://blog.cleancoder.com/uncle-bob/images/2012-08-13-the-clean-architecture/CleanArchitecture.jpg)

In our code base the folder is seperated like this:

![enter image description here](https://gcdnb.pbrd.co/images/agEESqZiwTgE.png?o=1)

The project goals is to seperate the folder by layer as the Clean Architecture principle **(Separation of Concern)**. the project utility is in core folder such like dependency injections, network, module, and etc (the more complex the app the more core utility we need).

The features files contains the feature/requirements of the project, seperating feature by folders, so every feature folder has data, domain, and presentation layer.

Since there is only one feature, so the Dashbord feature is only feature that exist in our codebase.
As the principle of **Clean Architecture** we often use one of the principle of SOLID which is **Dependency Inversion**, we can see communication between `Repository` and `DataSource` there is an abstract class as the bridge or media for the communcation/DTO so whenever we, for example, want to change the `DataSource` to get from local or anywhere else, we just need to change the logic in `DataSource` as long as the expected output still remains as before.

![enter image description here](https://gcdnb.pbrd.co/images/db1y4ELXVyzS.png?o=1)

Using this this approach really helps the developers to have a clear understanding about the objects, how the object interact to another and how the object have a single responsibility of its own function.

### State Management
I am using Provider for the state management. Because, it is simple, makes our development time faster, and powerfull especially for our project scope.

### Packages
|Packages|  Descriptions|
|--|--|
| dio |Provides media communication between client and server for http call|
| google_fonts| Easy implement of material fonts, because we use monsterrat font|
| provider| We use provider for the state management as it provides simple implementation but still can tackle many complex problems|
| injectable| Helps to pattern mathcing for classes/objects, it provide dynamic return of object, make our function simpler|
| dartz| Cutting boilerplate codes in DTO from data to presentation layer|
| get_it| Just give the dependency injection works to get_it, no more passing context through classes. Additionally, we focused on Seperation of Concern as we know needs to make the class loose coupled/decoupled. And the other benefits is we can easily mock classes that using get_it|
|mocktail| helps us to mock the class and also its parameter as well|
|hive_flutter|this package really helps us to store our state of the app like authentication and other specific tokens|
