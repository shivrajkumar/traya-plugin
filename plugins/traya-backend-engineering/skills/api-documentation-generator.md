---
name: api-documentation-generator
description: Automated API documentation generation for OpenAPI, Swagger, GraphQL schemas, and Postman collections. Use this skill when documenting REST APIs, GraphQL APIs, or event-driven architectures. Generates comprehensive documentation with examples, schemas, and interactive testing interfaces. Uses Postman MCP for collection generation, Context7 for documentation standards, and Serena for API structure analysis.
---

# API Documentation Generator

## Overview

This skill provides a complete automated API documentation generation workflow. The process analyzes your codebase, extracts API structure, generates OpenAPI/Swagger specifications, creates GraphQL schema documentation, builds Postman collections with tests, and publishes interactive documentation. The workflow ensures all APIs are properly documented with examples, schemas, and testing capabilities.

## Core Workflow

### Phase 1: Analyze Codebase & Extract API Structure

**1. Discover API Endpoints**

Use Serena MCP to analyze codebase structure:
```
mcp__serena__search_for_pattern - Search for API routes and controllers
mcp__serena__find_symbol - Find controller classes and route handlers
mcp__serena__get_symbols_overview - Understand API module structure
mcp__serena__get_code_graph - Map API endpoint relationships
```

Identify:
- All HTTP endpoints (REST)
- GraphQL queries and mutations
- WebSocket endpoints
- Event-driven APIs (queues, streams)
- Authentication endpoints
- Authorization requirements
- Request/response schemas
- Error responses

**2. Extract Route Metadata**

Analyze controllers and routes:

```typescript
// Example: Analyzing NestJS controller
import { Controller, Get, Post, Put, Delete, Param, Body, Query } from '@nestjs/common';

@Controller('users')
export class UserController {
  @Get()
  findAll(@Query('page') page: number) { ... }

  @Post()
  create(@Body() createDto: CreateUserDto) { ... }

  @Get(':id')
  findOne(@Param('id') id: string) { ... }

  @Put(':id')
  update(@Param('id') id: string, @Body() updateDto: UpdateUserDto) { ... }

  @Delete(':id')
  remove(@Param('id') id: string) { ... }
}

// Extracted structure:
// GET    /users          - List users (paginated)
// POST   /users          - Create user
// GET    /users/:id      - Get user by ID
// PUT    /users/:id      - Update user
// DELETE /users/:id      - Delete user
```

**3. Analyze Data Models**

Extract TypeScript interfaces and DTOs:

```typescript
// src/dtos/user.dto.ts
export class CreateUserDto {
  @IsEmail()
  email: string;

  @IsString()
  @MinLength(8)
  password: string;

  @IsString()
  name: string;
}

// Convert to JSON Schema:
{
  "type": "object",
  "required": ["email", "password", "name"],
  "properties": {
    "email": {
      "type": "string",
      "format": "email"
    },
    "password": {
      "type": "string",
      "minLength": 8
    },
    "name": {
      "type": "string"
    }
  }
}
```

**4. Research Documentation Standards**

Use Context7 MCP for best practices:
```
mcp__context7__get-library-docs - Get OpenAPI 3.1 specification
mcp__context7__get-library-docs - Get Swagger UI documentation
mcp__context7__get-library-docs - Get AsyncAPI specification
```

Research:
- OpenAPI 3.0/3.1 schema format
- Swagger UI configuration
- GraphQL schema documentation
- AsyncAPI for event-driven APIs
- Postman collection format v2.1

### Phase 2: Generate OpenAPI 3.0/3.1 Specification

**5. Create OpenAPI Specification**

Generate comprehensive OpenAPI spec:

```yaml
# openapi.yaml
openapi: 3.1.0
info:
  title: User Management API
  version: 1.0.0
  description: |
    Complete user management system with authentication and authorization.

    ## Authentication

    This API uses JWT bearer tokens for authentication. Include the token in the Authorization header:
    ```
    Authorization: Bearer {your-token}
    ```

    ## Rate Limiting

    - 100 requests per 15 minutes per IP
    - 5 login attempts per 15 minutes per IP

    ## Versioning

    The API is versioned using URL path versioning (e.g., `/api/v1/users`).

  contact:
    name: API Support
    email: support@example.com
    url: https://example.com/support
  license:
    name: MIT
    url: https://opensource.org/licenses/MIT

servers:
  - url: https://api.example.com/v1
    description: Production server
  - url: https://staging-api.example.com/v1
    description: Staging server
  - url: http://localhost:3000/api/v1
    description: Development server

tags:
  - name: Authentication
    description: User authentication and authorization
  - name: Users
    description: User management operations
  - name: Posts
    description: Blog post operations

paths:
  /auth/login:
    post:
      operationId: login
      summary: User login
      description: Authenticate user and receive JWT tokens
      tags:
        - Authentication
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/LoginRequest'
            examples:
              validLogin:
                summary: Valid login credentials
                value:
                  email: user@example.com
                  password: password123
      responses:
        '200':
          description: Login successful
          headers:
            X-RateLimit-Limit:
              description: The number of allowed requests in the current period
              schema:
                type: integer
            X-RateLimit-Remaining:
              description: The number of remaining requests in the current period
              schema:
                type: integer
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/AuthResponse'
              examples:
                success:
                  summary: Successful login response
                  value:
                    accessToken: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
                    refreshToken: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
                    user:
                      id: 123e4567-e89b-12d3-a456-426614174000
                      email: user@example.com
                      name: John Doe
                      role: user
        '401':
          $ref: '#/components/responses/UnauthorizedError'
        '429':
          $ref: '#/components/responses/TooManyRequests'

  /users:
    get:
      operationId: listUsers
      summary: List all users
      description: Retrieve a paginated list of users
      tags:
        - Users
      parameters:
        - name: page
          in: query
          description: Page number
          required: false
          schema:
            type: integer
            minimum: 1
            default: 1
          example: 1
        - name: limit
          in: query
          description: Number of items per page
          required: false
          schema:
            type: integer
            minimum: 1
            maximum: 100
            default: 20
          example: 20
        - name: search
          in: query
          description: Search term for filtering users
          required: false
          schema:
            type: string
          example: john
        - name: role
          in: query
          description: Filter by user role
          required: false
          schema:
            type: string
            enum: [admin, user, guest]
          example: user
      responses:
        '200':
          description: Users retrieved successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PaginatedUsersResponse'
              examples:
                paginatedUsers:
                  summary: Paginated user list
                  value:
                    data:
                      - id: 123e4567-e89b-12d3-a456-426614174000
                        email: user1@example.com
                        name: John Doe
                        role: user
                        createdAt: '2024-01-15T10:30:00Z'
                      - id: 223e4567-e89b-12d3-a456-426614174001
                        email: user2@example.com
                        name: Jane Smith
                        role: admin
                        createdAt: '2024-01-16T14:20:00Z'
                    meta:
                      page: 1
                      limit: 20
                      total: 150
                      totalPages: 8
        '400':
          $ref: '#/components/responses/BadRequest'

    post:
      operationId: createUser
      summary: Create a new user
      description: Create a new user account (Admin only)
      tags:
        - Users
      security:
        - bearerAuth: []
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CreateUserRequest'
            examples:
              newUser:
                summary: New user creation
                value:
                  email: newuser@example.com
                  password: securePassword123
                  name: New User
                  role: user
      responses:
        '201':
          description: User created successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'
        '400':
          $ref: '#/components/responses/BadRequest'
        '401':
          $ref: '#/components/responses/UnauthorizedError'
        '403':
          $ref: '#/components/responses/ForbiddenError'
        '409':
          description: Email already exists
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'
              example:
                statusCode: 409
                message: Email already exists
                error: Conflict

  /users/{id}:
    get:
      operationId: getUser
      summary: Get user by ID
      description: Retrieve a single user by their unique identifier
      tags:
        - Users
      parameters:
        - name: id
          in: path
          required: true
          description: User unique identifier
          schema:
            type: string
            format: uuid
          example: 123e4567-e89b-12d3-a456-426614174000
      responses:
        '200':
          description: User retrieved successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'
        '404':
          $ref: '#/components/responses/NotFound'

    put:
      operationId: updateUser
      summary: Update user
      description: Update user information
      tags:
        - Users
      security:
        - bearerAuth: []
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
            format: uuid
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/UpdateUserRequest'
      responses:
        '200':
          description: User updated successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'
        '401':
          $ref: '#/components/responses/UnauthorizedError'
        '404':
          $ref: '#/components/responses/NotFound'

    delete:
      operationId: deleteUser
      summary: Delete user
      description: Permanently delete a user account (Admin only)
      tags:
        - Users
      security:
        - bearerAuth: []
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
            format: uuid
      responses:
        '204':
          description: User deleted successfully
        '401':
          $ref: '#/components/responses/UnauthorizedError'
        '403':
          $ref: '#/components/responses/ForbiddenError'
        '404':
          $ref: '#/components/responses/NotFound'

components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT
      description: JWT token obtained from /auth/login endpoint

  schemas:
    User:
      type: object
      required:
        - id
        - email
        - name
        - role
        - createdAt
        - updatedAt
      properties:
        id:
          type: string
          format: uuid
          description: Unique user identifier
          example: 123e4567-e89b-12d3-a456-426614174000
        email:
          type: string
          format: email
          description: User email address
          example: user@example.com
        name:
          type: string
          minLength: 2
          maxLength: 100
          description: User full name
          example: John Doe
        role:
          type: string
          enum: [admin, user, guest]
          description: User role
          example: user
        avatar:
          type: string
          format: uri
          nullable: true
          description: User avatar URL
          example: https://example.com/avatars/user.jpg
        emailVerified:
          type: boolean
          description: Whether email is verified
          example: true
        createdAt:
          type: string
          format: date-time
          description: Account creation timestamp
          example: '2024-01-15T10:30:00Z'
        updatedAt:
          type: string
          format: date-time
          description: Last update timestamp
          example: '2024-01-20T14:45:00Z'
        lastLoginAt:
          type: string
          format: date-time
          nullable: true
          description: Last login timestamp
          example: '2024-01-25T09:15:00Z'

    CreateUserRequest:
      type: object
      required:
        - email
        - password
        - name
      properties:
        email:
          type: string
          format: email
          description: User email address
          example: newuser@example.com
        password:
          type: string
          format: password
          minLength: 8
          maxLength: 100
          description: User password (min 8 characters)
          example: securePassword123
        name:
          type: string
          minLength: 2
          maxLength: 100
          description: User full name
          example: New User
        role:
          type: string
          enum: [admin, user, guest]
          default: user
          description: User role
          example: user

    UpdateUserRequest:
      type: object
      properties:
        name:
          type: string
          minLength: 2
          maxLength: 100
          description: User full name
          example: Updated Name
        avatar:
          type: string
          format: uri
          description: User avatar URL
          example: https://example.com/avatars/new-avatar.jpg

    LoginRequest:
      type: object
      required:
        - email
        - password
      properties:
        email:
          type: string
          format: email
          example: user@example.com
        password:
          type: string
          format: password
          example: password123

    AuthResponse:
      type: object
      required:
        - accessToken
        - refreshToken
        - user
      properties:
        accessToken:
          type: string
          description: JWT access token (expires in 15 minutes)
          example: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
        refreshToken:
          type: string
          description: JWT refresh token (expires in 7 days)
          example: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
        user:
          type: object
          properties:
            id:
              type: string
              format: uuid
            email:
              type: string
              format: email
            name:
              type: string
            role:
              type: string

    PaginatedUsersResponse:
      type: object
      required:
        - data
        - meta
      properties:
        data:
          type: array
          items:
            $ref: '#/components/schemas/User'
        meta:
          $ref: '#/components/schemas/PaginationMeta'

    PaginationMeta:
      type: object
      required:
        - page
        - limit
        - total
        - totalPages
      properties:
        page:
          type: integer
          minimum: 1
          description: Current page number
          example: 1
        limit:
          type: integer
          minimum: 1
          maximum: 100
          description: Items per page
          example: 20
        total:
          type: integer
          minimum: 0
          description: Total number of items
          example: 150
        totalPages:
          type: integer
          minimum: 0
          description: Total number of pages
          example: 8

    Error:
      type: object
      required:
        - statusCode
        - message
      properties:
        statusCode:
          type: integer
          description: HTTP status code
          example: 400
        timestamp:
          type: string
          format: date-time
          description: Error timestamp
          example: '2024-01-25T10:30:00Z'
        path:
          type: string
          description: Request path
          example: /api/v1/users
        message:
          oneOf:
            - type: string
            - type: array
              items:
                type: string
          description: Error message(s)
          example: Validation failed
        error:
          type: string
          description: Error type
          example: Bad Request

  responses:
    BadRequest:
      description: Invalid request parameters
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'
          example:
            statusCode: 400
            message:
              - email must be a valid email address
              - password must be at least 8 characters
            error: Bad Request

    UnauthorizedError:
      description: Authentication required
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'
          example:
            statusCode: 401
            message: Invalid credentials
            error: Unauthorized

    ForbiddenError:
      description: Insufficient permissions
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'
          example:
            statusCode: 403
            message: Insufficient permissions
            error: Forbidden

    NotFound:
      description: Resource not found
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'
          example:
            statusCode: 404
            message: User not found
            error: Not Found

    TooManyRequests:
      description: Rate limit exceeded
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'
          example:
            statusCode: 429
            message: Too many requests, please try again later
            error: Too Many Requests
```

### Phase 3: Generate Swagger UI Integration

**6. Create Swagger UI Configuration**

Setup interactive API documentation:

```typescript
// src/config/swagger.config.ts
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { INestApplication } from '@nestjs/common';

export function setupSwagger(app: INestApplication): void {
  const config = new DocumentBuilder()
    .setTitle('User Management API')
    .setDescription(`
      Complete user management system with authentication and authorization.

      ## Getting Started

      1. Register a new account or use test credentials
      2. Login to receive JWT tokens
      3. Use the access token in the Authorization header
      4. Explore endpoints using the interactive documentation

      ## Authentication

      Click the "Authorize" button and enter your JWT token:
      \`Bearer {your-access-token}\`
    `)
    .setVersion('1.0.0')
    .setContact(
      'API Support',
      'https://example.com/support',
      'support@example.com'
    )
    .setLicense('MIT', 'https://opensource.org/licenses/MIT')
    .addBearerAuth(
      {
        type: 'http',
        scheme: 'bearer',
        bearerFormat: 'JWT',
        name: 'Authorization',
        description: 'Enter JWT token',
        in: 'header',
      },
      'bearerAuth'
    )
    .addTag('Authentication', 'User authentication and authorization')
    .addTag('Users', 'User management operations')
    .addTag('Posts', 'Blog post operations')
    .addServer('https://api.example.com/v1', 'Production')
    .addServer('https://staging-api.example.com/v1', 'Staging')
    .addServer('http://localhost:3000/api/v1', 'Development')
    .build();

  const document = SwaggerModule.createDocument(app, config);

  // Customize Swagger UI
  SwaggerModule.setup('api/docs', app, document, {
    customSiteTitle: 'User Management API Documentation',
    customfavIcon: 'https://example.com/favicon.ico',
    customCss: `
      .swagger-ui .topbar { display: none }
      .swagger-ui .info { margin: 50px 0 }
      .swagger-ui .scheme-container { background: #f7f7f7; padding: 20px }
    `,
    swaggerOptions: {
      persistAuthorization: true,
      displayRequestDuration: true,
      filter: true,
      showExtensions: true,
      showCommonExtensions: true,
      docExpansion: 'none',
      defaultModelsExpandDepth: 3,
      defaultModelExpandDepth: 3,
    },
  });
}
```

**7. Add Swagger Decorators to Controllers**

Enhance endpoints with documentation:

```typescript
// src/controllers/user.controller.ts
import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiBearerAuth,
  ApiParam,
  ApiQuery,
  ApiBody,
  ApiProduces,
  ApiConsumes,
} from '@nestjs/swagger';
import { UserService } from '@/services/user.service';
import { CreateUserDto, UserResponseDto } from '@/dtos/user.dto';

@ApiTags('Users')
@Controller('users')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Post()
  @ApiBearerAuth()
  @ApiOperation({
    summary: 'Create a new user',
    description: 'Create a new user account. Requires admin role.',
  })
  @ApiConsumes('application/json')
  @ApiProduces('application/json')
  @ApiBody({
    type: CreateUserDto,
    description: 'User creation data',
    examples: {
      validUser: {
        summary: 'Valid user data',
        value: {
          email: 'newuser@example.com',
          password: 'securePassword123',
          name: 'New User',
          role: 'user',
        },
      },
    },
  })
  @ApiResponse({
    status: 201,
    description: 'User created successfully',
    type: UserResponseDto,
  })
  @ApiResponse({
    status: 400,
    description: 'Invalid request data',
  })
  @ApiResponse({
    status: 409,
    description: 'Email already exists',
  })
  async create(@Body() createUserDto: CreateUserDto): Promise<UserResponseDto> {
    return this.userService.create(createUserDto);
  }

  @Get(':id')
  @ApiOperation({
    summary: 'Get user by ID',
    description: 'Retrieve a single user by their unique identifier',
  })
  @ApiParam({
    name: 'id',
    type: 'string',
    format: 'uuid',
    description: 'User unique identifier',
    example: '123e4567-e89b-12d3-a456-426614174000',
  })
  @ApiResponse({
    status: 200,
    description: 'User retrieved successfully',
    type: UserResponseDto,
  })
  @ApiResponse({
    status: 404,
    description: 'User not found',
  })
  async findById(@Param('id') id: string): Promise<UserResponseDto> {
    return this.userService.findById(id);
  }
}
```

### Phase 4: Generate AsyncAPI for Event-Driven APIs

**8. Create AsyncAPI Specification**

Document WebSocket and message queue APIs:

```yaml
# asyncapi.yaml
asyncapi: 3.0.0
info:
  title: User Events API
  version: 1.0.0
  description: |
    Real-time user events and notifications system.

    This API provides real-time updates for user-related events using WebSockets
    and message queues for asynchronous processing.
  contact:
    name: API Support
    email: support@example.com

servers:
  production:
    host: wss://api.example.com
    protocol: wss
    description: Production WebSocket server
  development:
    host: ws://localhost:3000
    protocol: ws
    description: Development WebSocket server
  messageQueue:
    host: amqp://rabbitmq.example.com:5672
    protocol: amqp
    description: RabbitMQ message broker

channels:
  user/created:
    address: user.created
    messages:
      userCreated:
        $ref: '#/components/messages/UserCreated'
    description: User creation events
    bindings:
      ws:
        method: POST

  user/updated:
    address: user.updated
    messages:
      userUpdated:
        $ref: '#/components/messages/UserUpdated'
    description: User update events

  user/deleted:
    address: user.deleted
    messages:
      userDeleted:
        $ref: '#/components/messages/UserDeleted'
    description: User deletion events

operations:
  onUserCreated:
    action: receive
    channel:
      $ref: '#/channels/user~1created'
    summary: User created event
    description: Triggered when a new user is created

  onUserUpdated:
    action: receive
    channel:
      $ref: '#/channels/user~1updated'
    summary: User updated event
    description: Triggered when a user is updated

  onUserDeleted:
    action: receive
    channel:
      $ref: '#/channels/user~1deleted'
    summary: User deleted event
    description: Triggered when a user is deleted

components:
  messages:
    UserCreated:
      name: UserCreated
      title: User Created Event
      summary: Emitted when a new user is created
      contentType: application/json
      payload:
        $ref: '#/components/schemas/UserEvent'
      examples:
        - name: newUser
          summary: New user creation event
          payload:
            eventId: 550e8400-e29b-41d4-a716-446655440000
            eventType: user.created
            timestamp: '2024-01-25T10:30:00Z'
            data:
              id: 123e4567-e89b-12d3-a456-426614174000
              email: newuser@example.com
              name: New User
              role: user

    UserUpdated:
      name: UserUpdated
      title: User Updated Event
      summary: Emitted when a user is updated
      contentType: application/json
      payload:
        $ref: '#/components/schemas/UserEvent'

    UserDeleted:
      name: UserDeleted
      title: User Deleted Event
      summary: Emitted when a user is deleted
      contentType: application/json
      payload:
        $ref: '#/components/schemas/UserEvent'

  schemas:
    UserEvent:
      type: object
      required:
        - eventId
        - eventType
        - timestamp
        - data
      properties:
        eventId:
          type: string
          format: uuid
          description: Unique event identifier
        eventType:
          type: string
          enum:
            - user.created
            - user.updated
            - user.deleted
          description: Event type
        timestamp:
          type: string
          format: date-time
          description: Event timestamp
        data:
          type: object
          description: Event payload
          properties:
            id:
              type: string
              format: uuid
            email:
              type: string
              format: email
            name:
              type: string
            role:
              type: string
```

### Phase 5: Generate GraphQL Schema Documentation

**9. Create GraphQL Schema with Documentation**

Generate comprehensive GraphQL documentation:

```graphql
# schema.graphql
"""
User Management GraphQL API

This API provides a complete user management system with queries
and mutations for creating, reading, updating, and deleting users.
"""
schema {
  query: Query
  mutation: Mutation
  subscription: Subscription
}

"""
Query root type providing read operations for users and posts
"""
type Query {
  """
  Get a single user by ID

  Example:
  ```graphql
  query {
    user(id: "123e4567-e89b-12d3-a456-426614174000") {
      id
      email
      name
    }
  }
  ```
  """
  user(
    """User unique identifier (UUID format)"""
    id: ID!
  ): User

  """
  List all users with pagination and filtering

  Example:
  ```graphql
  query {
    users(page: 1, limit: 20, role: USER) {
      data {
        id
        email
        name
      }
      meta {
        total
        totalPages
      }
    }
  }
  ```
  """
  users(
    """Page number (starting from 1)"""
    page: Int = 1

    """Number of items per page (max 100)"""
    limit: Int = 20

    """Filter by user role"""
    role: UserRole

    """Search term for filtering by name or email"""
    search: String
  ): PaginatedUsers!

  """
  Get current authenticated user

  Requires: Authentication
  """
  me: User!
}

"""
Mutation root type providing write operations
"""
type Mutation {
  """
  Create a new user account

  Requires: Admin role

  Example:
  ```graphql
  mutation {
    createUser(input: {
      email: "newuser@example.com"
      password: "securePassword123"
      name: "New User"
    }) {
      id
      email
      name
    }
  }
  ```
  """
  createUser(
    """User creation data"""
    input: CreateUserInput!
  ): User!

  """
  Update user information

  Requires: Authentication (own account) or Admin role

  Example:
  ```graphql
  mutation {
    updateUser(
      id: "123e4567-e89b-12d3-a456-426614174000"
      input: { name: "Updated Name" }
    ) {
      id
      name
    }
  }
  ```
  """
  updateUser(
    """User ID to update"""
    id: ID!

    """Updated user data"""
    input: UpdateUserInput!
  ): User!

  """
  Delete a user account

  Requires: Admin role
  """
  deleteUser(
    """User ID to delete"""
    id: ID!
  ): Boolean!

  """
  User login

  Returns JWT tokens for authentication

  Example:
  ```graphql
  mutation {
    login(input: {
      email: "user@example.com"
      password: "password123"
    }) {
      accessToken
      user {
        id
        email
      }
    }
  }
  ```
  """
  login(
    """Login credentials"""
    input: LoginInput!
  ): AuthPayload!
}

"""
Subscription root type for real-time updates
"""
type Subscription {
  """
  Subscribe to user creation events

  Example:
  ```graphql
  subscription {
    userCreated {
      id
      email
      name
    }
  }
  ```
  """
  userCreated: User!

  """
  Subscribe to user update events for a specific user
  """
  userUpdated(
    """User ID to watch"""
    id: ID!
  ): User!
}

"""
User account with profile information
"""
type User {
  """Unique user identifier (UUID format)"""
  id: ID!

  """User email address (unique)"""
  email: String!

  """User full name"""
  name: String!

  """User role determining permissions"""
  role: UserRole!

  """User avatar image URL"""
  avatar: String

  """Whether email has been verified"""
  emailVerified: Boolean!

  """Account creation timestamp"""
  createdAt: DateTime!

  """Last update timestamp"""
  updatedAt: DateTime!

  """Last login timestamp"""
  lastLoginAt: DateTime

  """Posts created by this user"""
  posts(
    """Page number"""
    page: Int = 1

    """Items per page"""
    limit: Int = 20
  ): PaginatedPosts!
}

"""
User role enumeration
"""
enum UserRole {
  """Administrator with full permissions"""
  ADMIN

  """Regular user with standard permissions"""
  USER

  """Guest user with limited permissions"""
  GUEST
}

"""
Paginated users response
"""
type PaginatedUsers {
  """Array of user objects"""
  data: [User!]!

  """Pagination metadata"""
  meta: PaginationMeta!
}

"""
Pagination metadata
"""
type PaginationMeta {
  """Current page number"""
  page: Int!

  """Items per page"""
  limit: Int!

  """Total number of items"""
  total: Int!

  """Total number of pages"""
  totalPages: Int!
}

"""
Input for creating a new user
"""
input CreateUserInput {
  """User email address"""
  email: String!

  """User password (minimum 8 characters)"""
  password: String!

  """User full name"""
  name: String!

  """User role (defaults to USER)"""
  role: UserRole = USER
}

"""
Input for updating a user
"""
input UpdateUserInput {
  """Updated user name"""
  name: String

  """Updated avatar URL"""
  avatar: String
}

"""
Input for user login
"""
input LoginInput {
  """User email address"""
  email: String!

  """User password"""
  password: String!
}

"""
Authentication response with tokens
"""
type AuthPayload {
  """JWT access token (expires in 15 minutes)"""
  accessToken: String!

  """JWT refresh token (expires in 7 days)"""
  refreshToken: String!

  """Authenticated user information"""
  user: User!
}

"""
DateTime scalar type (ISO 8601 format)
"""
scalar DateTime
```

### Phase 6: Generate Postman Collections with Test Scripts

**10. Create Postman Collection**

Use Postman MCP to generate collection:
```
mcp__postman__postman - Generate and validate Postman collection
```

Build comprehensive collection:

```json
{
  "info": {
    "name": "User Management API",
    "description": "Complete user management system with authentication",
    "version": "1.0.0",
    "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
  },
  "auth": {
    "type": "bearer",
    "bearer": [
      {
        "key": "token",
        "value": "{{accessToken}}",
        "type": "string"
      }
    ]
  },
  "variable": [
    {
      "key": "baseUrl",
      "value": "http://localhost:3000/api/v1",
      "type": "string"
    },
    {
      "key": "accessToken",
      "value": "",
      "type": "string"
    },
    {
      "key": "userId",
      "value": "",
      "type": "string"
    }
  ],
  "item": [
    {
      "name": "Authentication",
      "item": [
        {
          "name": "Login",
          "event": [
            {
              "listen": "test",
              "script": {
                "exec": [
                  "// Validate response status",
                  "pm.test('Status code is 200', function () {",
                  "    pm.response.to.have.status(200);",
                  "});",
                  "",
                  "// Validate response structure",
                  "pm.test('Response has required fields', function () {",
                  "    const jsonData = pm.response.json();",
                  "    pm.expect(jsonData).to.have.property('accessToken');",
                  "    pm.expect(jsonData).to.have.property('refreshToken');",
                  "    pm.expect(jsonData).to.have.property('user');",
                  "});",
                  "",
                  "// Save access token",
                  "pm.test('Save access token to environment', function () {",
                  "    const jsonData = pm.response.json();",
                  "    pm.collectionVariables.set('accessToken', jsonData.accessToken);",
                  "    pm.collectionVariables.set('userId', jsonData.user.id);",
                  "});",
                  "",
                  "// Validate JWT token format",
                  "pm.test('Access token is valid JWT', function () {",
                  "    const jsonData = pm.response.json();",
                  "    const tokenParts = jsonData.accessToken.split('.');",
                  "    pm.expect(tokenParts).to.have.lengthOf(3);",
                  "});",
                  "",
                  "// Validate response time",
                  "pm.test('Response time is less than 500ms', function () {",
                  "    pm.expect(pm.response.responseTime).to.be.below(500);",
                  "});"
                ],
                "type": "text/javascript"
              }
            }
          ],
          "request": {
            "method": "POST",
            "header": [
              {
                "key": "Content-Type",
                "value": "application/json"
              }
            ],
            "body": {
              "mode": "raw",
              "raw": "{\n  \"email\": \"admin@example.com\",\n  \"password\": \"admin123\"\n}"
            },
            "url": {
              "raw": "{{baseUrl}}/auth/login",
              "host": ["{{baseUrl}}"],
              "path": ["auth", "login"]
            }
          },
          "response": []
        }
      ]
    },
    {
      "name": "Users",
      "item": [
        {
          "name": "Create User",
          "event": [
            {
              "listen": "test",
              "script": {
                "exec": [
                  "pm.test('Status code is 201', function () {",
                  "    pm.response.to.have.status(201);",
                  "});",
                  "",
                  "pm.test('User has correct properties', function () {",
                  "    const jsonData = pm.response.json();",
                  "    pm.expect(jsonData).to.have.property('id');",
                  "    pm.expect(jsonData).to.have.property('email');",
                  "    pm.expect(jsonData).to.have.property('name');",
                  "    pm.expect(jsonData).to.not.have.property('password');",
                  "});",
                  "",
                  "pm.test('Email format is valid', function () {",
                  "    const jsonData = pm.response.json();",
                  "    pm.expect(jsonData.email).to.match(/^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$/);",
                  "});",
                  "",
                  "// Save user ID for subsequent requests",
                  "const jsonData = pm.response.json();",
                  "pm.collectionVariables.set('userId', jsonData.id);"
                ],
                "type": "text/javascript"
              }
            }
          ],
          "request": {
            "auth": {
              "type": "bearer",
              "bearer": [
                {
                  "key": "token",
                  "value": "{{accessToken}}",
                  "type": "string"
                }
              ]
            },
            "method": "POST",
            "header": [
              {
                "key": "Content-Type",
                "value": "application/json"
              }
            ],
            "body": {
              "mode": "raw",
              "raw": "{\n  \"email\": \"{{$randomEmail}}\",\n  \"password\": \"password123\",\n  \"name\": \"{{$randomFullName}}\"\n}"
            },
            "url": {
              "raw": "{{baseUrl}}/users",
              "host": ["{{baseUrl}}"],
              "path": ["users"]
            }
          },
          "response": []
        },
        {
          "name": "List Users",
          "event": [
            {
              "listen": "test",
              "script": {
                "exec": [
                  "pm.test('Status code is 200', function () {",
                  "    pm.response.to.have.status(200);",
                  "});",
                  "",
                  "pm.test('Response has pagination structure', function () {",
                  "    const jsonData = pm.response.json();",
                  "    pm.expect(jsonData).to.have.property('data');",
                  "    pm.expect(jsonData).to.have.property('meta');",
                  "    pm.expect(jsonData.data).to.be.an('array');",
                  "});",
                  "",
                  "pm.test('Pagination meta is correct', function () {",
                  "    const jsonData = pm.response.json();",
                  "    pm.expect(jsonData.meta).to.have.all.keys('page', 'limit', 'total', 'totalPages');",
                  "    pm.expect(jsonData.meta.page).to.be.a('number');",
                  "    pm.expect(jsonData.meta.total).to.be.at.least(0);",
                  "});"
                ],
                "type": "text/javascript"
              }
            }
          ],
          "request": {
            "method": "GET",
            "header": [],
            "url": {
              "raw": "{{baseUrl}}/users?page=1&limit=20",
              "host": ["{{baseUrl}}"],
              "path": ["users"],
              "query": [
                {
                  "key": "page",
                  "value": "1"
                },
                {
                  "key": "limit",
                  "value": "20"
                }
              ]
            }
          },
          "response": []
        },
        {
          "name": "Get User by ID",
          "event": [
            {
              "listen": "test",
              "script": {
                "exec": [
                  "pm.test('Status code is 200', function () {",
                  "    pm.response.to.have.status(200);",
                  "});",
                  "",
                  "pm.test('User ID matches requested ID', function () {",
                  "    const jsonData = pm.response.json();",
                  "    pm.expect(jsonData.id).to.equal(pm.collectionVariables.get('userId'));",
                  "});"
                ],
                "type": "text/javascript"
              }
            }
          ],
          "request": {
            "method": "GET",
            "header": [],
            "url": {
              "raw": "{{baseUrl}}/users/{{userId}}",
              "host": ["{{baseUrl}}"],
              "path": ["users", "{{userId}}"]
            }
          },
          "response": []
        },
        {
          "name": "Update User",
          "event": [
            {
              "listen": "test",
              "script": {
                "exec": [
                  "pm.test('Status code is 200', function () {",
                  "    pm.response.to.have.status(200);",
                  "});",
                  "",
                  "pm.test('User name was updated', function () {",
                  "    const jsonData = pm.response.json();",
                  "    pm.expect(jsonData.name).to.equal('Updated Name');",
                  "});"
                ],
                "type": "text/javascript"
              }
            }
          ],
          "request": {
            "auth": {
              "type": "bearer",
              "bearer": [
                {
                  "key": "token",
                  "value": "{{accessToken}}",
                  "type": "string"
                }
              ]
            },
            "method": "PUT",
            "header": [
              {
                "key": "Content-Type",
                "value": "application/json"
              }
            ],
            "body": {
              "mode": "raw",
              "raw": "{\n  \"name\": \"Updated Name\"\n}"
            },
            "url": {
              "raw": "{{baseUrl}}/users/{{userId}}",
              "host": ["{{baseUrl}}"],
              "path": ["users", "{{userId}}"]
            }
          },
          "response": []
        },
        {
          "name": "Delete User",
          "event": [
            {
              "listen": "test",
              "script": {
                "exec": [
                  "pm.test('Status code is 204', function () {",
                  "    pm.response.to.have.status(204);",
                  "});"
                ],
                "type": "text/javascript"
              }
            }
          ],
          "request": {
            "auth": {
              "type": "bearer",
              "bearer": [
                {
                  "key": "token",
                  "value": "{{accessToken}}",
                  "type": "string"
                }
              ]
            },
            "method": "DELETE",
            "header": [],
            "url": {
              "raw": "{{baseUrl}}/users/{{userId}}",
              "host": ["{{baseUrl}}"],
              "path": ["users", "{{userId}}"]
            }
          },
          "response": []
        }
      ]
    }
  ]
}
```

### Phase 7: Validate and Publish Documentation

**11. Validate OpenAPI Specification**

Validate generated documentation:

```typescript
// scripts/validate-openapi.ts
import * as SwaggerParser from '@apidevtools/swagger-parser';
import * as fs from 'fs';

async function validateOpenAPI() {
  try {
    const spec = fs.readFileSync('./openapi.yaml', 'utf8');
    const api = await SwaggerParser.validate(spec);

    console.log('✅ OpenAPI specification is valid!');
    console.log(`API: ${api.info.title} v${api.info.version}`);
    console.log(`Paths: ${Object.keys(api.paths).length}`);
    console.log(`Schemas: ${Object.keys(api.components?.schemas || {}).length}`);

    // Check for common issues
    const warnings: string[] = [];

    // Check for missing descriptions
    Object.entries(api.paths).forEach(([path, methods]: [string, any]) => {
      Object.entries(methods).forEach(([method, operation]: [string, any]) => {
        if (!operation.description) {
          warnings.push(`Missing description: ${method.toUpperCase()} ${path}`);
        }
        if (!operation.responses) {
          warnings.push(`Missing responses: ${method.toUpperCase()} ${path}`);
        }
      });
    });

    if (warnings.length > 0) {
      console.warn('\n⚠️  Warnings:');
      warnings.forEach(w => console.warn(`  - ${w}`));
    }

    return true;
  } catch (error) {
    console.error('❌ OpenAPI validation failed:', error);
    return false;
  }
}

validateOpenAPI();
```

**12. Generate Static Documentation**

Create HTML documentation:

```bash
# Install Redoc CLI
npm install -g redoc-cli

# Generate static HTML documentation
redoc-cli bundle openapi.yaml \
  --output docs/api-documentation.html \
  --title "User Management API Documentation" \
  --options.theme.colors.primary.main="#007bff"

# Or use Swagger UI
npx swagger-ui-cli bundle openapi.yaml \
  --output docs/swagger-ui.html
```

**13. Publish to Documentation Platform**

Deploy documentation:

```typescript
// scripts/publish-docs.ts
import { execSync } from 'child_process';
import * as fs from 'fs';

async function publishDocumentation() {
  // Generate documentation
  console.log('📚 Generating documentation...');
  execSync('redoc-cli bundle openapi.yaml -o docs/index.html');

  // Publish to GitHub Pages
  console.log('🚀 Publishing to GitHub Pages...');
  execSync('git checkout gh-pages');
  execSync('cp docs/index.html .');
  execSync('git add index.html');
  execSync('git commit -m "Update API documentation"');
  execSync('git push origin gh-pages');
  execSync('git checkout main');

  console.log('✅ Documentation published successfully!');
  console.log('🔗 https://yourusername.github.io/your-repo/');
}

publishDocumentation();
```

## Best Practices

1. **Keep Documentation in Sync**: Auto-generate from code
2. **Provide Examples**: Include request/response examples
3. **Document Error Cases**: All possible error responses
4. **Use Semantic Versioning**: Version your API properly
5. **Add Descriptions**: Explain what each endpoint does
6. **Include Authentication**: Document auth requirements
7. **Show Rate Limits**: Document all limitations
8. **Validate Specifications**: Use linters and validators
9. **Test Postman Collections**: Ensure all tests pass
10. **Publish Publicly**: Make docs accessible
11. **Use Standard Formats**: OpenAPI, AsyncAPI, GraphQL SDL
12. **Add Code Examples**: Multiple language examples
13. **Document Webhooks**: Include async event documentation
14. **Keep It Updated**: Automate updates in CI/CD
15. **Get Feedback**: Allow users to suggest improvements

## Completion Criteria

Documentation generation is complete when:

1. ✅ All endpoints discovered and cataloged
2. ✅ OpenAPI 3.1 specification is complete
3. ✅ Swagger UI is configured and accessible
4. ✅ AsyncAPI specification for events created
5. ✅ GraphQL schema is fully documented
6. ✅ Postman collection generated with tests
7. ✅ All examples are working and tested
8. ✅ Specifications validated successfully
9. ✅ Static documentation generated
10. ✅ Documentation published and accessible
11. ✅ All schemas have descriptions
12. ✅ All endpoints have examples
13. ✅ Authentication documented completely
14. ✅ Error responses documented
15. ✅ Rate limits documented

## Success Metrics

Measure documentation quality by:

- **Coverage**: 100% of endpoints documented
- **Completeness**: All fields have descriptions
- **Examples**: Every endpoint has request/response examples
- **Accuracy**: Documentation matches implementation
- **Accessibility**: Docs are public and searchable
- **Interactivity**: Swagger UI allows testing
- **Validation**: All specs pass validation
- **Automation**: Docs auto-update on code changes

Success is achieved when developers can understand and integrate with your API using only the documentation, without needing to read the source code or ask questions.
