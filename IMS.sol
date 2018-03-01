pragma solidity ^0.4.18;
import "./Token.sol";
contract Inven_system is EIP20
{
    bytes5[] internal List;
    uint[] internal pricelist;
    uint public saleamount=0;
    uint public saletoken=0;
    
     function buyToKen(uint tokens)  payable
 {  
     if(msg.value!=(tokens*price))
     {
         throw;
     }
     balances[msg.sender]+=tokens;
     balances[owner]-=tokens;
     totalSupply-=tokens;
                saletoken=saletoken+tokens;

     owner.transfer(msg.value);
     if(totalSupply<0)
 {
     selfdestruct(owner);
 }
 } 
 struct  p
 {
     string coursename;
     string grade;
     uint availabilty;
     bool stockin;
     uint priceinToken;
 }
 struct c
 {
     string name;
     string buying_product;
     uint percentage;
     uint quantity;
 }
 function studententry(uint id,string _name,uint _percentage)
 {
     customer[id].name=_name;
     customer[id].percentage=_percentage;
 }
 function courseavailable(uint id) public view returns(string)
 {
     if(90<=customer[id].percentage&&customer[id].percentage>100)
     {
         return "offer id 1";
         
     }
     else if(80<=customer[id].percentage&&customer[id].percentage>90)
     {
         return "offer id 2";
     }
     else if(70<=customer[id].percentage&&customer[id].percentage>80)
     {
         return "offer id 3";
     }
     else
     {
         return "no offer for you,go to regular side";
     }
     
 }
 mapping(uint=>c) public customer;
 mapping(bytes5=>p) public products;
 bytes5[] internal pack1;
 function setproducts(bytes5 id,string _pname,string _grade,uint _avail,uint _priceintoken) public
 {
     products[id].coursename=_pname;
     products[id].availabilty=_avail;
     products[id].grade=_grade;
     products[id].stockin=true;
     products[id].priceinToken=_priceintoken;
     pack1.push(id);
 }
 function sold(uint id,string _name,bytes5 productname,uint price) public 
 { 
    if(products[productname].availabilty>0&&price==products[productname].priceinToken)
    {         customer[id].name=_name;
              customer[id].buying_product=products[productname].coursename;
              customer[id].quantity++;
              products[productname].availabilty--;
              products[productname].stockin=true; List.push(productname);
           pricelist.push(products[productname].priceinToken);
          saleamount=saleamount+(100*(products[productname].priceinToken));
          balances[msg.sender]-=price;
     }
    else
    {   
          products[productname].stockin=false;
    }

    }
 function productlist() public view returns(bytes5[])
 {
     return pack1;
 }
 function salelist() public view returns(bytes5[],uint[])
 {
     return (List,pricelist);
 }
 function noproducts() public view returns(uint)
 {
     return pack1.length;
      }
 }

