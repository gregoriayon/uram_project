from datetime import datetime, timezone
from sqlalchemy.dialects.postgresql import TIMESTAMP

from app import db

class Roles(db.Model):
    __tablename__ = 'roles'

    id = db.Column(db.Integer(), primary_key=True, autoincrement=True)
    role_name = db.Column(db.String(), nullable=False, unique=True)
    created_by = db.Column(db.String(), nullable=True)
    created_at = db.Column(
        TIMESTAMP(timezone=True), 
        default=lambda: datetime.now(timezone.utc), 
        nullable=False
    )

    apis = db.relationship(
        'RolesAPI', 
        backref='role', 
        cascade='all, delete-orphan'
    )

    users_role = db.relationship(
        'UsersRole',
        backref='users_role',
        cascade='all, delete-orphan'
    )

    def __repr__(self):
        return f"<Role {self.role_name}>"



# SQL create table scripts
# CREATE TABLE roles (
#     id SERIAL PRIMARY KEY,
#     role_name VARCHAR NOT NULL UNIQUE,
#     created_by VARCHAR,
#     created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
# );