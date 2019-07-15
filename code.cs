namespace MyCode {

    public class MyClass {
        public string MyProperty {get;set;}
        #if V2 
        public bool OnlyInV2 {get;set;}
        #endif
    }

    #if V2
    public class MyClassInV2 {
        public string MyV2Property {get;set;}
    }
    #endif
}