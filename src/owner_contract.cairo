#[starknet::interface]
// trait definition
trait IOwnable<T> {
    fn set_owner(ref self: T, new_owner: ContractAddress);
    fn get_owner(self: @T) -> ContractAddress;
}

#[starknet::contract]
mod OwnerContract {
    #[storage]
    struct Storage {
        owner: ContractAddress,
    }

    #[abi_embed(v0)]
    // #[external(v0)]
    impl OwnableImpl of IOwnable<ContractState> {
        //semi access
        fn owner_write(ref self: ContractState, new_owner: ContractAddress) {
            // Check if the sender is the owner
           if self.sender() != self.owner.read() {
               // If not, revert the transaction
               revert()
           }
           self.owner.write(new_owner);
        }
        fn get_owner(self: @ContractState) -> ContractAddress {
            self.owner.read()
        }
    }

    //full access control
       fn owner_write(ref self: ContractState, new_owner: ContractAddress) {
          // Check if the sender is the owner
          if self.sender() != self.owner.read() {
              // If not, revert the transaction
              revert()
          }
          self.owner.write(new_owner);
      }
      fn owner_read(self: @ContractState) -> ContractAddress {
          // Check if the sender is the owner
          if self.sender() != self.owner.read() {
              // If not, revert the transaction
              revert()
          }
          self.owner.read()
      }
  }

