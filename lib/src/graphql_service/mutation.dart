final String mutation = r"""
  mutation addProfile(
      $emails: String!, 
      $first_names: String!,
      $mid_names: String!,
      $last_names: String!,
      $genders: String!,
      $document_ids: String!
      $user_statuses: String!
    ){
    verifyUser(
        email: $emails, 
        first_name: $first_names
        mid_name: $mid_names,
        last_name: $last_names,
        gender: $genders,
        document_id: $document_ids,
        user_status: $user_statuses
      ){
      email
      first_name
      mid_name
      last_name
      gender
      document_id
      user_status
    }
  }
""";