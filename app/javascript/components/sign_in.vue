<template>
    <div id="sign_in">
        <template v-if="errors.base && errors.base.length">
            <template v-for="error in errors.base">
                <div class="alert alert-danger" role="alert">
                    {{ error }}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </template>
        </template>

        <h1>Sign In</h1>

        <form @submit.prevent="onSubmit" novalidate :class="{ 'was-validated': isValidated }">
            <div class="form-group">
                <label for="email" class="sr-only">Email:</label>
                <input id="email"
                       type="email"
                       class="form-control"
                       :class="validOrNotEmailClass()"
                       placeholder="john.appleseed@example.com"
                       autofocus
                       required
                       v-model="email">
                <template v-if="errors.email && errors.email.length">
                    <div class="invalid-feedback">
                        <template v-for="error in errors.email">
                            {{ error }}
                        </template>
                    </div>
                </template>
                <template v-else>
                    <div class="valid-feedback">
                        Looks good!
                    </div>
                </template>
            </div>

            <div class="form-group">
                <label for="password" class="sr-only">Password:</label>
                <input id="password"
                       type="password"
                       class="form-control"
                       :class="validOrNotPasswordClass()"
                       placeholder="Password"
                       required
                       v-model="password">
                <template v-if="errors.password && errors.password.length">
                    <div class="invalid-feedback">
                        <template v-for="error in errors.password">
                            {{ error }}
                        </template>
                    </div>
                </template>
                <template v-else>
                    <div class="valid-feedback">
                        Looks good!
                    </div>
                </template>
            </div>

            <div class="form-group">
                <button type="submit" class="btn btn-primary btn-block">Sign in</button>
            </div>

            <hr />

            <div class="form-group">
                <a href="/auth/eve_online_sso"><img src="https://images.contentful.com/idjq7aai9ylm/4fSjj56uD6CYwYyus4KmES/4f6385c91e6de56274d99496e6adebab/EVE_SSO_Login_Buttons_Large_Black.png?w=270&h=45" alt="Sign in via EveOnline SSO"></a>
            </div>
        </form>
    </div>
</template>

<script>
    import { mapActions } from 'vuex';

    export default {
        data () {
            return {
                email: '',
                password: '',
                errors: {
                    base: [],
                    email: [],
                    password: []
                },
                isValidated: false
            }
        },

        methods: {
            ...mapActions({
                'signIn': 'signIn'
            }),

            onSubmit () {
                const formData = {
                    sign_in: {
                        email: this.email,
                        password: this.password
                    }
                };

                this.signIn(formData).then(response => {
                    if (response && response.status === 200) {
                        this.$router.push('/profile');
                    } else if (response.response && response.response.status === 422) {
                        this.isValidated = true;
                        this.errors = response.response.data.errors;
                    }
                });
            },

            validOrNotEmailClass () {
                if (this.isValidated === true) {
                    if (this.errors.email && this.errors.email.length) {
                        return 'is-invalid';
                    } else {
                        return 'is-valid';
                    }
                } else {
                    return '';
                }
            },

            validOrNotPasswordClass () {
                if (this.isValidated === true) {
                    if (this.errors.password && this.errors.password.length) {
                        return 'is-invalid';
                    } else {
                        return 'is-valid';
                    }
                } else {
                    return '';
                }
            }
        }
    }
</script>
