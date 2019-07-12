final String mutation = r"""
  mutation addProfile(
      $emails: String!,
      $first_names: String!,
      $mid_names: String!,
      $last_names: String!,
      $genders: String!,
      $document_ids: String!,
      $user_statuses: String!,
      $tempTokens: String!,
      $create_ids: String!,
      $updated_ids: String!
    ){
    verifyUser(
      email: $emails,
      first_name: $first_names,
      mid_name: $mid_names,
      last_name: $last_names,
      gender: $genders,
      wallet: $wallets,
      document_id: $document_ids,
      user_status: $user_statuses,
      tempToke: $tempTokens,
      create_id: $create_ids,
      updated_id: $updated_ids
      ){
        email
    }
  }
""";

//       mutation{
//   verifyUser(email: "user5@gmail.com",
//     first_name: "Daveat",
//     mid_name: "",
//     last_name: "",
//     description: "",
//     gender: "",
//     profile_img: "",
//     document_id: ""
//     user_status: "",
//     Nationality: "",
//     Occupation: "",
//     Country: "",
//     City: "",
//     CountryCode: "",
//     PhoneNumber: "",
//     BuildingNumber: "",
//     Address: "",
//     PostalCode: ""
//   ){
//     email
//   }
// }