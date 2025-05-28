""""
file = open('Biogragphy_safi.txt', 'r')

content = file.read()
print("\n",content)
file.close()


"""





####         Welcome to Our ATM     #####
Account_amout = 500000

def receipt(withdraw,remaining):
    remaining_amount = remaining
    withdraw_amount = withdraw
    file_write = open('customer_receipt.txt','w')
    content = file_write.write("Thank you so much for Using Our Service\n")
    content = file_write.write(f"Remaining Amount: {remaining_amount}\n")
    content = file_write.write(f"Withdraw Amount: {withdraw_amount}\n")
    file_write.close()
    file = open('customer_receipt.txt', 'r')
    content = file.read()
    print("\n",content)
    file.close()
    print("Please get your receipt from ATM Machine :)")


withdraw_amount = input("How much amount you want to withdraw: ")
remaining_amount = int(Account_amout) - int(withdraw_amount)


consent = input("Can you please want to get receipt: ")
if consent == 'yes':
    receipt(withdraw_amount,remaining_amount)
elif consent == 'No':
    print("Please Collect your money")
    
