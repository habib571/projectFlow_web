class AddMemberRequest {
 final int memberId ;
  final int projectId;
 final String role ;
 AddMemberRequest(this.memberId, this.projectId, this.role);
 Map<String, dynamic> toJson() {
   return {
     'member_id': memberId,
     'project_id': projectId,
     'role': role,
   };
 }

}