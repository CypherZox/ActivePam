public class Item {
        String name;
        double price;
        long quantity;
        
    public static void main (String args[]){
        Item i1 = new Item();
        UseItems i = new UseItems();
        i1.setName("milk");
        i1.setPrice(10.0);
        i1.setQuantity(100);
        i.addItem(i1);
        System.out.println("Your're searching for");
        i.findItem(i1.getName());
        System.out.println("Item Quantity");
        System.out.println(i1.getQuantity());
        i.buyItem("milk",30);
        i.sellItem("milk",30);
        System.out.println("Item report after customer purchase");
        i.report();
    }


    public Item(){}
    public String getName(){
        return this.name;
    }
    public double getPrice(){
        return this.price;
    }
    public long getQuantity(){
        return this.quantity;
    }
    public void setName(String name){
        this.name=name;
    }
    public void setPrice(double price){
        this.price=price;
    }
    public void setQuantity(long quantity){
        this.quantity=quantity;
        
    }  
}


class UseItems extends Item{
    int num=99999;
    int n=0;
    Item [] stock=new Item [num];

    public void addItem(Item item){    
        stock[n]=item;
        n++;
    }
     public void buyItem(String name,long b){
        for(int j=0;j<n;j++){
        if(stock[j].name.equals(name)){
            System.out.println("ordered Item               ordered quantity");
            
            System.out.println(stock[j].name+"               "+b);
            
        }
    }
}
    public void findItem(String name){
        for(int j=0;j<n;j++){
        if(stock[j].name.equals(name)){
            System.out.println("Item               price");
            System.out.println(stock[j].name+"               "+stock[j].price);
        }
        }
    }
    public void findPrice(String name){
        for(int j=0;j<n;j++){
        if(stock[j].name.equals(name)){
            System.out.println("Item               Price");
            System.out.println(stock[j].name+"               "+stock[j].price);
        }
    }
}
          public void report(){
            System.out.println("Item               quantity");
            
            for(int j=0;j<n;j++){
            System.out.println(stock[j].name+"                  "+stock[j].quantity);
        }
    }
     public void sellItem(String name,long b){
        
        for(int j=0;j<n;j++){
    
        if(stock[j].name.equals(name)){
            System.out.println("Item               quantity               price               total price");
            System.out.println(stock[j].name+"               "+b+"               "+stock[j].price+"               "+(stock[j].price)*b);
            (this.stock[j].quantity)-=b;
        }
    }}
 }
    
    
